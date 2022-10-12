package mylib

import spinal.core._
import spinal.lib._
//import scala.language.implicitConversions


object BundleImplicit
{
	implicit class autoConnect(bus: Bundle)
	{
		def connect(srcBus: Bundle): Unit =
		{
			bus.connectWithSrcNull(srcBus)
			srcBus.connectWithSrcNull(bus)
			bus.connectWithSrc(srcBus)
			// srcBus.connectWithSrc(bus)
		}


		def connectWithSrcNull(srcBus: Bundle) =
		{
			for((name, element) <- bus.elements)
			{
				val srcPort = srcBus.find(name)
				if (srcPort == null)
				{
					element match
					{
						case b: Bundle => b.setToZero()
						case _		   =>
						{
							if (element.isOutput || element.isDirectionLess)
							{
								println(Console.RED + s"${element} have no driver, assign to 0" + Console.RESET)
								element.assignFromBits(B(0, element.getBitsWidth bits))
							}
						}
					}

				}
			}

		}

		def connectWithSrc(srcBus: Bundle): Unit =
		{
			for((name, element) <- bus.elements)
			{
				val srcPort = srcBus.find(name)
				if (srcPort != null)
				{
					element match
					{
						case b: Bundle => b.connect(srcPort.asInstanceOf[Bundle])
						case _ =>
						{
							(element.getDirection, srcPort.getDirection) match
							{
								case (`out`, `in`) 								=> assignWithAdapt(element, srcPort)
								case (`out`, null) 								=> assignWithAdapt(element, srcPort)
								case (`in`, `out`) 								=> assignWithAdapt(srcPort, element)
								case (`in`, null) 								=> assignWithAdapt(srcPort, element)
								case (null, `in`) 								=> assignWithAdapt(element, srcPort)
								case (null, `out`)								=> assignWithAdapt(srcPort, element)
								case _ if element.isAnalog && srcPort.isAnalog 	=> assignWithAdapt(element, srcPort)
								case _ 											=> LocatedPendingError(s"DIRECTION MISMATCH, impossible to infer the connection direction between $element and $srcPort ")

							}
						}
					}

				}
			}

		}


		def assignWithAdapt(dst: Data, src: Data): Unit =
		{
			if (dst.getBitsWidth != src.getBitsWidth)
			{
				println(Console.RED + s"$dst width is different from $src, auto resized." + Console.RESET)
				dst := src.resized
			}
			else
			{
				dst := src
			}
		}

		def setToZero(): Unit =
		{
			for ((name, element) <- bus.elements)
			{
				element match
				{
					case b: Bundle => b.setToZero()
					case _: Bundle =>
					{
						if (element.isOutput || element.isDirectionLess)
						{
							println(Console.RED + s"${element} have no driver, assign to 0." + Console.RESET)
							if (element.isInstanceOf[Bool])
							{
								element := False
							}
							else
							{
								element.assignFromBits(B(0, element.getBitsWidth bits))
							}
						}
					}
				}
			}
		}

	}
}