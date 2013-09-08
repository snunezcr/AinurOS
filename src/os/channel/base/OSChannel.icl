/*
 * AinurOS: a Functional Exascale Operating System
 * Santiago Nunez-Corrales (santiago@fuper.cr)
 * Copyright 2013
 *
 * This file is part of AinurOS.
 *
 * AinurOS is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * AinurOS is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with AinurOS.  If not, see <http://www.gnu.org/licenses/>
 */

implementation module OSChannel

:: OSChannelState	= Hold
			| FlowOne
			| FlowMany
			| FlowAll

::OSChannelMode		= Upstream
			| Downstream
			| Both

::OSChannelMsg 		= undef

:: OSChannelMsgT	= BaseMessage
			| ControlMessage
			| ComputeMessage
			| IOMessage
			| ProfileMessage
			| DebugMessage
			| ServiceMessage
			| AccessMessage

::OSChannel =	{ up_ports :: [OSPort]
		, down_ports :: [OSPort]
		, msg_types :: [OSChannelMsgT]
		, state :: OSChannelState
		, mode :: OSChannelMode
		, flow_count :: Int
		, bandwidth :: Int
		, capacity :: Int
		, content :: [OSChannelMsg]
		, priority :: Int
		}

oschannel_set_state :: OSChannel OSChannelState -> OSChannel
oschannel_set_state ch st = { ch & state = st }

oschannel_set_mode :: OSChannel OSChannelMode -> OSChannel
oschannel_set_mode ch md = {ch & mode = md}

oschannel_set_flow :: OSChannel Int -> OSChannel
oschannel_set_flow ch n = {ch & flow_count = n}

oschannel_is_full :: OSChannel -> Bool
oschannel_is_full ch = lenght ch.content == capacity

oschannel_queue :: OSChannel OSChannelMsg -> OSChannel
oschannel_queue ch msg = {ch & content = [msg:ch.content]}

oschannel_send :: OSChannel -> OSChannel
oschannel_send ch
	| ch.state == Hold	= ch

oschannel_send_all :: OSChannel -> OSChannel

oschannel_filter :: OSChannel [OSChannelMsgT] -> OSChannel



