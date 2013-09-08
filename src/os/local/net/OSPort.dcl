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

definition module OSPort

::OSPort

osport_transport :: OSChannelMsg OSPort -> OSPort

