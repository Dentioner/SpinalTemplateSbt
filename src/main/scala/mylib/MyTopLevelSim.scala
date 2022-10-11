package mylib

import spinal.core._
import spinal.lib._
import spinal.core.sim._

class addsim(dataWidth: Int) extends MyTopLevel(dataWidth)
{
	def init =
	{
		clockDomain.forkStimulus(10)
		io.addflow0.dataflow.valid #= false
		io.addflow1.dataflow.valid #= false
		clockDomain.waitSampling(10)
	}

	def test(f: myflow, data1: Int, data2: Int) =
	{
		f.dataflow.valid #= true
		f.dataflow.data1 #= data1
		f.dataflow.data2 #= data2
		clockDomain.waitSampling()
		f.dataflow.valid #= false
		clockDomain.waitSamplingWhere(f.sumflow.valid.toBoolean)
		assert((data1 + data2) == f.sumflow.payload.toInt, "data Mismathc")
	}
}

object mytestbench extends App
{

//	def main(args: Array[String]): Unit =
	{


		SimConfig
		.withWave
		.withConfig(SpinalConfig(
			defaultClockDomainFrequency = FixedFrequency(100 MHz),
			defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC)
		))
		.compile(new addsim(8))
		.doSim
		{
			dut =>
				dut.init
				dut.test(dut.io.addflow0, 3, 5)
				dut.test(dut.io.addflow1, 3, 5)
		}
	}
}


//object DutTest
//{
//	def main(args: Array[String]): Unit =
//	{
//		SimConfig
//			.withWave
//			.withConfig(SpinalConfig(
//				defaultClockDomainFrequency = FixedFrequency(100 MHz),
//				defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC)))
//			.compile(new addInstSim(8))
//			.doSim
//			{
//				dut =>
//						dut.init
//						dut.test(dut.io.addflow0, 3, 5)
//						dut.test(dut.io.addflow1, 3, 5)
//				// Simulation code here
//			}
//	}
//}


