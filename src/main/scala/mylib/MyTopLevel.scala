/*
 * SpinalHDL
 * Copyright (c) Dolu, All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3.0 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.
 */

package mylib

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axilite.AxiLite4
import spinal.lib.fsm._

import scala.util.Random

//Hardware definition

// case class config(bitsPerGroup:Int=2, dataWidth:Int=8)
// {
// 	require(dataWidth % bitsPerGroup == 0, "Invalid parameter")
// 	val sigOutWidth = dataWidth / bitsPerGroup
// }

case class myflow(dataWidth: Int) extends Bundle with IMasterSlave
{
	case class datas(dataWidth: Int) extends Bundle
	{
		val data1 = UInt(dataWidth bits)
		val data2 = UInt(dataWidth bits)
	}

	val dataflow = Flow(datas(dataWidth))
	val sumflow = Flow(UInt(dataWidth bits))

	override def asMaster(): Unit = 
	{
		master(dataflow)
		slave(sumflow)
	}

	def inner_add(): Unit =
	{
		sumflow.payload := RegNextWhen((dataflow.payload.data1 + dataflow.payload.data2), dataflow.valid);
		sumflow.valid := RegNext(dataflow.valid, False);
	}
}

class myadder(dataWidth: Int) extends Component
{
	val io = new Bundle
	{
		val validIn = in Bool()
		val data1 = in UInt(dataWidth bits)
		val data2 = in UInt(dataWidth bits)
		val sum = out UInt(dataWidth bits)
		val sumValid = out Bool()
	}

	io.sum := RegNextWhen((io.data1 + io.data2), io.validIn);
	io.sumValid := RegNext(io.validIn, False);
}

class myadder2(dataWidth: Int) extends Component
{
	val io = new Bundle
	{
		val dataIn = slave(myflow(dataWidth))
	}


	io.dataIn.sumflow.payload := RegNextWhen((io.dataIn.dataflow.payload.data1 + io.dataIn.dataflow.payload.data2), io.dataIn.dataflow.valid);
	io.dataIn.sumflow.valid := RegNext(io.dataIn.dataflow.valid, False);
}

object myadder2
{
	def apply(dataWidth: Int, f: myflow)
	{
		val adder = new myadder2(dataWidth)
		f <> adder.io.dataIn
	}
}

case class add_area(dataIn: myflow) extends Area
{
	dataIn.sumflow.payload := RegNextWhen((dataIn.dataflow.payload.data1 + dataIn.dataflow.payload.data2), dataIn.dataflow.valid);
	dataIn.sumflow.valid := RegNext(dataIn.dataflow.valid, False);
}


class MyTopLevel(dataWidth: Int=8) extends Component 
{
	val io = new Bundle 
	{
		// val cond0 = in  Bool()
		// val cond1 = in  Bool()
		// val flag  = out Bool()
		// val state = out UInt(8 bits)
		// val result = out UInt()
		val liteIn = slave(AxiLite4(32, 32))
		val liteOut = master(AxiLite4(64, 64))
	}

//	io.liteIn <> io.liteOut

	import BundleImplicit._
//	io.liteIn connect io.liteOut
	val alite = AxiLite4(64, 32)
	alite connect io.liteIn
	io.liteOut connect alite
//	io.liteIn connect alite
//	alite connect io.liteOut
}


//Generate the MyTopLevel's Verilog
// object MyTopLevelVerilog 
// {
// 	def main(args: Array[String]) 
// 	{
// 		SpinalVerilog(new MyTopLevel)
// 	}
// }

//Generate the MyTopLevel's VHDL
// object MyTopLevelVhdl 
// {
// 	def main(args: Array[String]) 
// 	{
// 		SpinalVhdl(new MyTopLevel)
// 	}
// }


//Define a custom SpinalHDL configuration with synchronous reset instead of the default asynchronous one. This configuration can be resued everywhere
object MySpinalConfig extends SpinalConfig(
	defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC),
	targetDirectory = "generated/")

//Generate the MyTopLevel's Verilog using the above custom configuration.
object MyTopLevelVerilogWithCustomConfig 
{
	def main(args: Array[String]) 
	{
		// val conf = new config()
		MySpinalConfig.generateVerilog(new MyTopLevel)
	}
}