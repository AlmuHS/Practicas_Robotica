clear all
clc
COM_CloseNXT all;
handle = COM_OpenNXT('bluetooth.ini_nxt')
COM_SetDefaultNXT(handle)