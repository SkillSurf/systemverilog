/* 
####################################################################################################
# SAED 32/28NM 1p9m milkyway technology file						    	   #
# Author:         SWG   								   	   #
# drawing grid:   0.001 microns								   	   #
#											    	   #
# Revision History:									  	   #
# Rev.		date		what							    	   #
# -------------------------------------------------------------------------------------	  	   #	
# 0.1		14/Jan/2011	(First draft)						   	   #
#                                                                                        	   #
# 0.2           12/Dec/2011     (Second draft)  	Changed  M1 from minSpacing = 0.05  to     #  
#                                              		minSpacing = 0.056.                        #
#												   #
# 0.3		14/Dec/2011	(Third draft)   	Corrected "fattbldimension" attribute for  #
#					       		M9 layer. (This error was the reason of    #
#					       		fatal error in ICC) .       		   # 
#												   #
# 0.4           16/Dec/2011     (Forth draft) 	 	Corrected Pitchs Of M* metal  layers.      #
#												   #
# 0.5		18/Dec/2011	(Fifth draft) 	 	Corrected measurement units, correspon-    #
#					      		ding to technology libraries units.	   #
#					      	 	Added cut*-tables and DesignRules for them #
#					      		for Zroute algorithm in ICC.		   #
#												   #
# 0.6		12/Jul/2012	(Six draft)   		Corrected Stackable option to different    #
#							vias	 				   #
# 0.7		17/Jul/2012	(Seventh draft)		Add Metal Span Spacing Rule		   #
#												   #
# 0.8		unknown		(Eight draft)		- removed metal span spacing rules         #
#							- removed concaveMetalToCutMinDist         #
#							- changed cutTblSize to 8 when 8 entries   #
#							  present in the CutTbl                    #
#                                                                                                  #
# 0.9		15/12/2012	(Cut table issues)	- Changed cutTblSize to 4 as there are     # 
#							  only 4 cut combinations according to DRM #
#                                                       - Removed extra cut names                  #
#							- Changed cut names to differ from         #
#							  ContactCode names                        #
#                                                       - Removed sameNetMinSpacing from M1        #
#                                                       - Fixed rounded fat table thresholds       # 
#                                                         reported by (TFCHK-055)                  #
#												   #
# 0.10		03/Feb/2021				- Removed second redundant definition for  # 
#							  BAR vias   				   #
#							- Added fatTbl definitions for all vias    #
#							- Updated design rules                     #
#--------------------------------------------------------------------------------------------------#
# Known Issues:						    				           #
#                                                                                                  #
# 1. Warning TFCHK-110, for unknown reason      	    				           #
# 2. Warning TFCHK-109, for unknown reason      	    				           #
# 3. Warning TFCHK-080, which should be ignored as coding matches documentation		           #
#                                                                                                  #
####################################################################################################

#######################################################################
####                                                               ####
####  The data contained in the file is created for educational    #### 
####  and training purposes only and are not recommended           ####
####  for fabrication                                              ####
####                                                               ####
#######################################################################
####                                                               ####
####  Copyright (C) 2013 Synopsys, Inc.                            ####
####                                                               ####
#######################################################################
####                                                               ####
####  The 32/28nm Generic Library ("Library") is unsupported       ####    
####  Confidential Information of Synopsys, Inc. ("Synopsys")      ####    
####  provided to you as Documentation under the terms of the      ####    
####  End User Software License Agreement between you or your      ####    
####  employer and Synopsys ("License Agreement") and you agree    ####    
####  not to distribute or disclose the Library without the        ####    
####  prior written consent of Synopsys. The Library IS NOT an     ####    
####  item of Licensed Software or Licensed Product under the      ####    
####  License Agreement.  Synopsys and/or its licensors own        ####    
####  and shall retain all right, title and interest in and        ####    
####  to the Library and all modifications thereto, including      ####    
####  all intellectual property rights embodied therein. All       ####    
####  rights in and to any Library modifications you make are      ####    
####  hereby assigned to Synopsys. If you do not agree with        ####    
####  this notice, including the disclaimer below, then you        ####    
####  are not authorized to use the Library.                       ####    
####                                                               ####  
####                                                               ####      
####  THIS LIBRARY IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN   ####
####  "AS IS" BASIS, WITH NO INTELLECUTAL PROPERTY                 ####
####  INDEMNIFICATION AND NO SUPPORT. ANY EXPRESS OR IMPLIED       ####
####  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED       ####
####  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR   ####
####  PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS    ####
####  BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,     ####
####  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT      ####
####  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;     ####
####  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)     ####
####  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN    ####
####  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE    ####
####  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS      ####
####  DOCUMENTATION, EVEN IF ADVISED OF THE POSSIBILITY OF         ####
####  SUCH DAMAGE.                                                 #### 
####                                                               ####  
#######################################################################


*/

Technology	{
		name				= "saed32"
		date				= "Dec 20 2012"
		dielectric			= 3.45e-05
		unitTimeName			= "ns"
		timePrecision			= 1000
		unitLengthName			= "micron"
		lengthPrecision			= 1000
		gridResolution			= 1
		unitVoltageName			= "V"
		voltagePrecision		= 1000000
		unitCurrentName			= "uA"
		currentPrecision		= 1
		unitPowerName			= "pw"
		powerPrecision			= 1000
		unitResistanceName		= "kohm"
		resistancePrecision		= 10000
		unitCapacitanceName		= "ff"
		capacitancePrecision		= 10000
		unitInductanceName		= "nh"
		inductancePrecision		= 100
		minBaselineTemperature		= 25
		nomBaselineTemperature		= 25
		maxBaselineTemperature		= 25
		minEdgeMode			= 1
}

Color		6 {
		name				= "6"
		rgbDefined			= 1
		redIntensity			= 0
		greenIntensity			= 80
		blueIntensity			= 190
}

Color		8 {
		name				= "8"
		rgbDefined			= 1
		redIntensity			= 0
		greenIntensity			= 175
		blueIntensity			= 0
}

Color		10 {
		name				= "10"
		rgbDefined			= 1
		redIntensity			= 0
		greenIntensity			= 175
		blueIntensity			= 190
}

Color		11 {
		name				= "11"
		rgbDefined			= 1
		redIntensity			= 0
		greenIntensity			= 175
		blueIntensity			= 255
}

Color		13 {
		name				= "13"
		rgbDefined			= 1
		redIntensity			= 0
		greenIntensity			= 255
		blueIntensity			= 100
}

Color		20 {
		name				= "20"
		rgbDefined			= 1
		redIntensity			= 90
		greenIntensity			= 80
		blueIntensity			= 0
}

Color		23 {
		name				= "23"
		rgbDefined			= 1
		redIntensity			= 90
		greenIntensity			= 80
		blueIntensity			= 255
}

Color		25 {
		name				= "25"
		rgbDefined			= 1
		redIntensity			= 90
		greenIntensity			= 175
		blueIntensity			= 100
}

Color		27 {
		name				= "27"
		rgbDefined			= 1
		redIntensity			= 90
		greenIntensity			= 175
		blueIntensity			= 255
}

Color		28 {
		name				= "28"
		rgbDefined			= 1
		redIntensity			= 90
		greenIntensity			= 255
		blueIntensity			= 0
}

Color		31 {
		name				= "31"
		rgbDefined			= 1
		redIntensity			= 90
		greenIntensity			= 255
		blueIntensity			= 255
}

Color		32 {
		name				= "32"
		rgbDefined			= 1
		redIntensity			= 180
		greenIntensity			= 0
		blueIntensity			= 0
}

Color		34 {
		name				= "34"
		rgbDefined			= 1
		redIntensity			= 180
		greenIntensity			= 0
		blueIntensity			= 190
}

Color		35 {
		name				= "35"
		rgbDefined			= 1
		redIntensity			= 180
		greenIntensity			= 0
		blueIntensity			= 255
}

Color		36 {
		name				= "36"
		rgbDefined			= 1
		redIntensity			= 180
		greenIntensity			= 80
		blueIntensity			= 0
}

Color		38 {
		name				= "38"
		rgbDefined			= 1
		redIntensity			= 180
		greenIntensity			= 80
		blueIntensity			= 190
}

Color		40 {
		name				= "40"
		rgbDefined			= 1
		redIntensity			= 180
		greenIntensity			= 175
		blueIntensity			= 0
}

Color		43 {
		name				= "43"
		rgbDefined			= 1
		redIntensity			= 180
		greenIntensity			= 175
		blueIntensity			= 255
}

Color		44 {
		name				= "44"
		rgbDefined			= 1
		redIntensity			= 180
		greenIntensity			= 255
		blueIntensity			= 0
}

Color		47 {
		name				= "47"
		rgbDefined			= 1
		redIntensity			= 180
		greenIntensity			= 255
		blueIntensity			= 255
}

Color		50 {
		name				= "50"
		rgbDefined			= 1
		redIntensity			= 255
		greenIntensity			= 0
		blueIntensity			= 190
}

Color		51 {
		name				= "ltGreen"
		rgbDefined			= 1
		redIntensity			= 0
		greenIntensity			= 240
		blueIntensity			= 110
}

Color		52 {
		name				= "52"
		rgbDefined			= 1
		redIntensity			= 255
		greenIntensity			= 80
		blueIntensity			= 0
}

Color		54 {
		name				= "54"
		rgbDefined			= 1
		redIntensity			= 255
		greenIntensity			= 80
		blueIntensity			= 190
}

Color		58 {
		name				= "58"
		rgbDefined			= 1
		redIntensity			= 255
		greenIntensity			= 175
		blueIntensity			= 190
}

Color		59 {
		name				= "59"
		rgbDefined			= 1
		redIntensity			= 255
		greenIntensity			= 175
		blueIntensity			= 255
}

Color		62 {
		name				= "62"
		rgbDefined			= 1
		redIntensity			= 255
		greenIntensity			= 255
		blueIntensity			= 190
}

Stipple		"impdot" {
		width			= 16
		height			= 16
		pattern			= (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1) 
}

Stipple		"hidot" {
		width			= 16
		height			= 16
		pattern			= (1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1) 
}

Stipple		"rhidot" {
		width			= 16
		height			= 16
		pattern			= (0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 
					   0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 
					   1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0) 
}

Stipple		"twelldot" {
		width			= 16
		height			= 16
		pattern			= (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) 
}

Stipple		"welldot" {
		width			= 16
		height			= 16
		pattern			= (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) 
}

Tile		"unit" {
		width				= 0.152
		height				= 1.672
}

Layer		"NWELL" {
		layerNumber			= 1
		maskName			= "nwell"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "lead"
		lineStyle			= "solid"
		pattern				= "backSlash"
		pitch				= 0
		defaultWidth			= 0.23
		minWidth			= 0.23
		minSpacing			= 0.23
}

Layer		"DNW" {
		layerNumber			= 2
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "36"
		lineStyle			= "solid"
		pattern				= "backSlash"
		pitch				= 0
		defaultWidth			= 3
		minWidth			= 3
		minSpacing			= 3.5
}

Layer		"DIFF" {
		layerNumber			= 3
		maskName			= "active"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "40"
		lineStyle			= "solid"
		pattern				= "solid"
		pitch				= 0
		defaultWidth			= 0.044
		minWidth			= 0.044
		minSpacing			= 0.05
}

LayerDataType		"DDMY" {
		layerNumber			= 3
		dataTypeNumber			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "40"
		lineStyle			= "solid"
		pattern				= "brick"
}

Layer		"PIMP" {
		layerNumber			= 4
		maskName			= "pplus"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "32"
		lineStyle			= "solid"
		pattern				= "dot"
		pitch				= 0
		defaultWidth			= 0.102
		minWidth			= 0.102
		minSpacing			= 0.17
}

Layer		"NIMP" {
		layerNumber			= 5
		maskName			= "nplus"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "ltGreen"
		lineStyle			= "solid"
		pattern				= "dot"
		pitch				= 0
		defaultWidth			= 0.102
		minWidth			= 0.102
		minSpacing			= 0.17
}

Layer		"DIFF_18" {
		layerNumber			= 6
		maskName			= "18volt"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "yellow"
		lineStyle			= "solid"
		pattern				= "zigzag"
		pitch				= 0
		defaultWidth			= 0.33
		minWidth			= 0.33
		minSpacing			= 0.33
}

Layer		"PAD" {
		layerNumber			= 7
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "orange"
		lineStyle			= "dash"
		pattern				= "solid"
		pitch				= 0
		defaultWidth			= 55
		minWidth			= 55
		minSpacing			= 10
}

Layer		"ESD_25" {
		layerNumber			= 8
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "drab"
		lineStyle			= "dash"
		pattern				= "zigzag"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"SBLK" {
		layerNumber			= 9
		maskName			= "sblk"
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "62"
		lineStyle			= "dash"
		pattern				= "solid"
		pitch				= 0
		defaultWidth			= 0.33
		minWidth			= 0.33
		minSpacing			= 0.33
}

Layer		"PO" {
		layerNumber			= 10
		maskName			= "poly"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "red"
		lineStyle			= "none"
		pattern				= "solid"
		pitch				= 0
		defaultWidth			= 0.03
		minWidth			= 0.03
		minSpacing			= 0.122
		minArea				= 0.012
}

LayerDataType		"PODMY" {
		layerNumber			= 10
		dataTypeNumber			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "red"
		lineStyle			= "none"
		pattern				= "brick"
}

Layer		"M1" {
			/* layout attributes */
		layerNumber			= 11
		isDefaultLayer			= 1
		maskName			= "metal1"
		pitch				= 0.152
			/* display attributes */
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "blue"
		lineStyle			= "solid"
		pattern				= "impdot"
			/* design rule attributes */
		
		minWidth			= 0.05
		maxWidth			= 5		
		defaultWidth			= 0.05
		minSpacing			= 0.05
/*		sameNetMinSpacing		= 0.055 */

		
		fatTblDimension			= 5
		fatTblThreshold			= (0,0.151,0.301,1.501,3.001)
		fatTblParallelLength		= (0,0.151,0.301,1.501,3.001)
		fatTblSpacing			= (0.05,0.06,0.1,0.5,0.6,
						   0.06,0.06,0.1,0.5,0.6,
						   0.1,0.1,0.1,0.5,0.6,
						   0.5,0.5,0.5,0.5,0.6,
						   0.6,0.6,0.6,0.6,0.6)

		protrusionTblDim       		= 3 			
		protrusionFatThresholdTbl       = (0.15,0.3,1.5)
		protrusionLengthLimitTbl       	= (0.1,0.17,0.7)
		protrusionMinWidthTbl 		= (0.06,0.07,0.15)

		minArea				= 0.01
		minEnclosedArea			= 0.2
		
}

LayerDataType	"M1DMY" {
		layerNumber			= 11
		dataTypeNumber			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "blue"
		lineStyle			= "solid"
		pattern				= "brick"
}

Layer		"VIA1" {
		layerNumber			= 12
		maskName			= "via1"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "cyan"
		lineStyle			= "solid"
		pattern				= "rectangleX"
		/*pitch				= 0.36*/
		defaultWidth			= 0.05
		minWidth			= 0.05
		minSpacing			= 0.07
		fatTblDimension			= 2
		fatTblThreshold			= (0.0, 0.16)
		fatTblDimension2		= 2
		fatTblThreshold2		= (0.0, 0.16)
		fatTblFatContactNumber		= (" 1, 5", " 3, 7, 1, 5", " 3, 7, 1, 5", " 4, 8, 3, 7, 1, 5")
		fatTblFatContactMinCuts		= (" 1, 1", " 1, 1, 2, 2", " 1, 1, 2, 2", " 1, 1, 2, 2, 4, 4")
		cutTblSize			= 3
		cutNameTbl			= (V1SQ, V1BAR, V1LG)
		cutWidthTbl			= (0.05, 0.05,  0.1)
		cutHeightTbl			= (0.05, 0.1,   0.1)
		sameSegAlignedUpperWireMaxSpacingThreshold = 0.08
		sameSegAlignedLowerWireMaxSpacingThreshold = 0.08
		sameSegAlignedCutMinSpacing = 0.07

}

Layer		"M2" {
		layerNumber			= 13
		maskName			= "metal2"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "50"
		lineStyle			= "solid"
		pattern				= "twelldot"
		pitch				= 0.152
		defaultWidth			= 0.056
		minWidth			= 0.056
		minSpacing			= 0.056
		maxWidth			= 5
		sameNetMinSpacing		= 0.056
		
		protrusionTblDim       		= 4 			
		protrusionFatThresholdTbl       = (0.15,0.3,1.5,3)
		protrusionLengthLimitTbl       	= (0.1,0.15,0.7,1.5)
		protrusionMinWidthTbl 		= (0.06,0.07,0.15,0.3)

		fatTblDimension			= 5
		fatTblThreshold			= (0.005,0.155,0.305,1.505,3.005)
		fatTblParallelLength		= (0,0.15,0.3,1.5,3)
		fatTblSpacing			= (0.056,0.064,0.12,0.6,0.7,
						   0.064,0.064,0.12,0.6,0.7,
						   0.12,0.12,0.12,0.6,0.7,
						   0.6,0.6,0.6,0.6,0.7,
						   0.7,0.7,0.7,0.7,0.7)

		minArea				= 0.016
		minEnclosedArea			= 0.2
		
}

LayerDataType		"M2DMY" {
		layerNumber			= 13
		dataTypeNumber			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "50"
		lineStyle			= "solid"
		pattern				= "brick"
}

Layer		"VIA2" {
		layerNumber			= 14
		maskName			= "via2"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "yellow"
		lineStyle			= "solid"
		pattern				= "rectangleX"
		/*pitch				= 0.36*/
		defaultWidth			= 0.05
		minWidth			= 0.05
		minSpacing			= 0.07
		fatTblDimension			= 2
		fatTblThreshold			= (0.0, 0.16)
		fatTblDimension2		= 2
		fatTblThreshold2		= (0.0, 0.16)
		fatTblFatContactNumber		= (" 9,13", "11,15, 9,13", "11,15, 9,13", "12,16,11,15, 9,13")
		fatTblFatContactMinCuts		= (" 1, 1", " 1, 1, 2, 2", " 1, 1, 2, 2", " 1, 1, 2, 2, 4, 4")
		cutTblSize			= 3
		cutNameTbl			= (V2SQ, V2BAR, V2LG)
		cutWidthTbl			= (0.05, 0.05,  0.1)
		cutHeightTbl			= (0.05, 0.1,   0.1)
		
		sameSegAlignedUpperWireMaxSpacingThreshold = 0.08
		sameSegAlignedLowerWireMaxSpacingThreshold = 0.08
		sameSegAlignedCutMinSpacing = 0.07
}

Layer		"M3" {
		layerNumber			= 15
		maskName			= "metal3"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "38"
		lineStyle			= "solid"
		pattern				= "hidot"
		pitch				= 0.304
		defaultWidth			= 0.056
		minWidth			= 0.056
		minSpacing			= 0.056
		maxWidth			= 5
		sameNetMinSpacing		= 0.056

		protrusionTblDim       		= 4 			
		protrusionFatThresholdTbl       = (0.15,0.3,1.5,3)
		protrusionLengthLimitTbl       	= (0.1,0.15,0.7,1.5)
		protrusionMinWidthTbl 		= (0.06,0.07,0.15,0.3)

		fatTblDimension			= 5
		fatTblThreshold			= (0.005,0.155,0.305,1.505,3.005)
		fatTblParallelLength		= (0.005,0.155,0.305,1.505,3.005)
		fatTblSpacing			= (0.056,0.064,0.12,0.6,0.7,
						   0.064,0.064,0.12,0.6,0.7,
						   0.12,0.12,0.12,0.6,0.7,
						   0.6,0.6,0.6,0.6,0.7,
						   0.7,0.7,0.7,0.7,0.7)
		minArea				= 0.016
		minEnclosedArea			= 0.2
}

LayerDataType		"M3DMY" {
		layerNumber			= 15
		dataTypeNumber			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "38"
		lineStyle			= "solid"
		pattern				= "brick"
}

Layer		"VIA3" {
		layerNumber			= 16
		maskName			= "via3"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "27"
		lineStyle			= "solid"
		pattern				= "rectangleX"
		/*pitch				= 0.36*/
		defaultWidth			= 0.05
		minWidth			= 0.05
		minSpacing			= 0.07
		fatTblDimension			= 2
		fatTblThreshold			= (0.0, 0.16)
		fatTblDimension2		= 2
		fatTblThreshold2		= (0.0, 0.16)
		fatTblFatContactNumber		= ("17,21", "19,23,17,21", "19,23,17,21", "20,24,19,23,17,21")
		fatTblFatContactMinCuts		= (" 1, 1", " 1, 1, 2, 2", " 1, 1, 2, 2", " 1, 1, 2, 2, 4, 4")
		cutTblSize			= 3
		cutNameTbl			= (V3SQ, V3BAR, V3LG)
		cutWidthTbl			= (0.05, 0.05,  0.1)
		cutHeightTbl			= (0.05, 0.1,   0.1)
		sameSegAlignedUpperWireMaxSpacingThreshold = 0.08
		sameSegAlignedLowerWireMaxSpacingThreshold = 0.08
		sameSegAlignedCutMinSpacing = 0.07
}

Layer		"M4" {
		layerNumber			= 17
		maskName			= "metal4"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "green"
		lineStyle			= "solid"
		pattern				= "rhidot"
		pitch				= 0.304
		defaultWidth			= 0.056
		minWidth			= 0.056
		minSpacing			= 0.056
		maxWidth			= 5
		sameNetMinSpacing		= 0.056
		
		protrusionTblDim       		= 4 			
		protrusionFatThresholdTbl       = (0.15,0.3,1.5,3)
		protrusionLengthLimitTbl       	= (0.1,0.15,0.7,1.5)
		protrusionMinWidthTbl 		= (0.06,0.07,0.15,0.3)

		fatTblDimension			= 5
		fatTblThreshold			= (0.005,0.155,0.305,1.505,3.005)
		fatTblParallelLength		= (0.005,0.155,0.305,1.505,3.005)
		fatTblSpacing			= (0.056,0.064,0.12,0.6,0.7,
						   0.064,0.064,0.12,0.6,0.7,
						   0.12,0.12,0.12,0.6,0.7,
						   0.6,0.6,0.6,0.6,0.7,
						   0.7,0.7,0.7,0.7,0.7)
		minArea				= 0.016
		minEnclosedArea			= 0.2
}

LayerDataType		"M4DMY" {
		layerNumber			= 17
		dataTypeNumber			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "green"
		lineStyle			= "solid"
		pattern				= "brick"
}

Layer		"VIA4" {
		layerNumber			= 18
		maskName			= "via4"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "orange"
		lineStyle			= "solid"
		pattern				= "rectangleX"
		/*pitch				= 0.36*/
		defaultWidth			= 0.05
		minWidth			= 0.05
		minSpacing			= 0.07
		fatTblDimension			= 2
		fatTblThreshold			= (0.0, 0.16)
		fatTblDimension2		= 2
		fatTblThreshold2		= (0.0, 0.16)
		fatTblFatContactNumber		= ("25,29", "27,31,25,29", "27,31,25,29", "28,32,27,31,25,29")
		fatTblFatContactMinCuts		= (" 1, 1", " 1, 1, 2, 2", " 1, 1, 2, 2", " 1, 1, 2, 2, 4, 4")
		cutTblSize			= 3
		cutNameTbl			= (V4SQ, V4BAR, V4LG)
		cutWidthTbl			= (0.05, 0.05,  0.1)
		cutHeightTbl			= (0.05, 0.1,   0.1)
		sameSegAlignedUpperWireMaxSpacingThreshold = 0.08
		sameSegAlignedLowerWireMaxSpacingThreshold = 0.08
		sameSegAlignedCutMinSpacing = 0.07
}

Layer		"M5" {
		layerNumber			= 19
		maskName			= "metal5"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "aqua"
		lineStyle			= "solid"
		pattern				= "welldot"
		pitch				= 0.608
		defaultWidth			= 0.056
		minWidth			= 0.056
		minSpacing			= 0.056
		maxWidth			= 5
		sameNetMinSpacing		= 0.056

		protrusionTblDim       		= 4 			
		protrusionFatThresholdTbl       = (0.15,0.3,1.5,3)
		protrusionLengthLimitTbl       	= (0.1,0.15,0.7,1.5)
		protrusionMinWidthTbl 		= (0.06,0.07,0.15,0.3)

		fatTblDimension			= 5
		fatTblThreshold			= (0.005,0.155,0.305,1.505,3.005)
		fatTblParallelLength		= (0.005,0.155,0.305,1.505,3.005)
		fatTblSpacing			= (0.056,0.064,0.12,0.6,0.7,
						   0.064,0.064,0.12,0.6,0.7,
						   0.12,0.12,0.12,0.6,0.7,
						   0.6,0.6,0.6,0.6,0.7,
						   0.7,0.7,0.7,0.7,0.7)
		minArea				= 0.016
		minEnclosedArea			= 0.2
}

LayerDataType		"M5DMY" {
		layerNumber			= 19
		dataTypeNumber			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "aqua"
		lineStyle			= "solid"
		pattern				= "brick"
}

Layer		"VIA5" {
		layerNumber			= 20
		maskName			= "via5"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "40"
		lineStyle			= "solid"
		pattern				= "rectangleX"
		/*pitch				= 0.36*/
		defaultWidth			= 0.05
		minWidth			= 0.05
		minSpacing			= 0.07
		fatTblDimension			= 2
		fatTblThreshold			= (0.0, 0.16)
		fatTblDimension2		= 2
		fatTblThreshold2		= (0.0, 0.16)
		fatTblFatContactNumber		= ("33,37", "35,39,33,37", "35,39,33,37", "36,40,35,39,33,37")
		fatTblFatContactMinCuts		= (" 1, 1", " 1, 1, 2, 2", " 1, 1, 2, 2", " 1, 1, 2, 2, 4, 4")
		cutTblSize			= 3
		cutNameTbl			= (V5SQ, V5BAR, V5LG)
		cutWidthTbl			= (0.05, 0.05,  0.1)
		cutHeightTbl			= (0.05, 0.1,   0.1)
		sameSegAlignedUpperWireMaxSpacingThreshold = 0.08
		sameSegAlignedLowerWireMaxSpacingThreshold = 0.08
		sameSegAlignedCutMinSpacing = 0.07
}

Layer		"M6" {
		layerNumber			= 21
		maskName			= "metal6"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "58"
		lineStyle			= "solid"
		pattern				= "impdot"
		pitch				= 0.608
		defaultWidth			= 0.056
		minWidth			= 0.056
		minSpacing			= 0.056
		maxWidth			= 5
		sameNetMinSpacing		= 0.056
		
		protrusionTblDim       		= 4 			
		protrusionFatThresholdTbl       = (0.15,0.3,1.5,3)
		protrusionLengthLimitTbl       	= (0.1,0.15,0.7,1.5)
		protrusionMinWidthTbl 		= (0.06,0.07,0.15,0.3)

		fatTblDimension			= 5
		fatTblThreshold			= (0.005,0.155,0.305,1.505,3.005)
		fatTblParallelLength		= (0.005,0.155,0.305,1.505,3.005)
		fatTblSpacing			= (0.056,0.064,0.12,0.6,0.7,
						   0.064,0.064,0.12,0.6,0.7,
						   0.12,0.12,0.12,0.6,0.7,
						   0.6,0.6,0.6,0.6,0.7,
						   0.7,0.7,0.7,0.7,0.7)
		minArea				= 0.016
		minEnclosedArea			= 0.2
}

LayerDataType		"M6DMY" {
		layerNumber			= 21
		dataTypeNumber			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "58"
		lineStyle			= "solid"
		pattern				= "brick"
}

Layer		"VIA6" {
		layerNumber			= 22
		maskName			= "via6"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "52"
		lineStyle			= "solid"
		pattern				= "rectangleX"
		/*pitch				= 0.36*/
		defaultWidth			= 0.05
		minWidth			= 0.05
		minSpacing			= 0.07
		fatTblDimension			= 2
		fatTblThreshold			= (0.0, 0.16)
		fatTblDimension2		= 2
		fatTblThreshold2		= (0.0, 0.16)
		fatTblFatContactNumber		= ("41,45", "43,47,41,45", "43,47,41,45", "44,48,43,47,41,45")
		fatTblFatContactMinCuts		= (" 1, 1", " 1, 1, 2, 2", " 1, 1, 2, 2", " 1, 1, 2, 2, 4, 4")
		cutTblSize			= 3
		cutNameTbl			= (V6SQ, V6BAR, V6LG)
		cutWidthTbl			= (0.05, 0.05,  0.1)
		cutHeightTbl			= (0.05, 0.1,   0.1)
		sameSegAlignedUpperWireMaxSpacingThreshold = 0.08
		sameSegAlignedLowerWireMaxSpacingThreshold = 0.08
		sameSegAlignedCutMinSpacing = 0.07
}

Layer		"M7" {
		layerNumber			= 23
		maskName			= "metal7"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "cyan"
		lineStyle			= "solid"
		pattern				= "twelldot"
		pitch				= 1.216
		defaultWidth			= 0.056
		minWidth			= 0.056
		minSpacing			= 0.056
		maxWidth			= 5
		sameNetMinSpacing		= 0.056

		protrusionTblDim       		= 4 			
		protrusionFatThresholdTbl       = (0.15,0.3,1.5,3)
		protrusionLengthLimitTbl       	= (0.1,0.15,0.7,1.5)
		protrusionMinWidthTbl 		= (0.06,0.07,0.15,0.3)

		fatTblDimension			= 5
		fatTblThreshold			= (0.005,0.155,0.305,1.505,3.005)
		fatTblParallelLength		= (0.005,0.155,0.305,1.505,3.005)
		fatTblSpacing			= (0.056,0.064,0.12,0.6,0.7,
						   0.064,0.064,0.12,0.6,0.7,
						   0.12,0.12,0.12,0.6,0.7,
						   0.6,0.6,0.6,0.6,0.7,
						   0.7,0.7,0.7,0.7,0.7)
		minArea				= 0.016
		minEnclosedArea			= 0.2
}

LayerDataType		"M7DMY" {
		layerNumber			= 23
		dataTypeNumber			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "cyan"
		lineStyle			= "solid"
		pattern				= "brick"
}

Layer		"VIA7" {
		layerNumber			= 24
		maskName			= "via7"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "blue"
		lineStyle			= "solid"
		pattern				= "rectangleX"
		/*pitch				= 0.36*/
		defaultWidth			= 0.05
		minWidth			= 0.05
		minSpacing			= 0.07
		fatTblDimension			= 2
		fatTblThreshold			= (0.0, 0.16)
		fatTblDimension2		= 2
		fatTblThreshold2		= (0.0, 0.16)
		fatTblFatContactNumber		= ("49,53", "51,55,49,53", "51,55,49,53", "52,56,51,55,49,53")
		fatTblFatContactMinCuts		= (" 1, 1", " 1, 1, 2, 2", " 1, 1, 2, 2", " 1, 1, 2, 2, 4, 4")
		cutTblSize			= 3
		cutNameTbl			= (V7SQ, V7BAR, V7LG)
		cutWidthTbl			= (0.05, 0.05,  0.1)
		cutHeightTbl			= (0.05, 0.1,   0.1)
		sameSegAlignedUpperWireMaxSpacingThreshold = 0.08
		sameSegAlignedLowerWireMaxSpacingThreshold = 0.08
		sameSegAlignedCutMinSpacing 	= 0.07
}

Layer		"M8" {
		layerNumber			= 25
		maskName			= "metal8"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "43"
		lineStyle			= "solid"
		pattern				= "hidot"
		pitch				= 1.216
		defaultWidth			= 0.056
		minWidth			= 0.056
		minSpacing			= 0.056
		maxWidth			= 5
		sameNetMinSpacing		= 0.056

		protrusionTblDim       		= 4 			
		protrusionFatThresholdTbl       = (0.15,0.3,1.5,3)
		protrusionLengthLimitTbl       	= (0.1,0.15,0.7,1.5)
		protrusionMinWidthTbl 		= (0.06,0.07,0.15,0.3)

		fatTblDimension			= 5
		fatTblThreshold			= (0.005,0.155,0.305,1.505,3.005)
		fatTblParallelLength		= (0.005,0.155,0.305,1.505,3.005)
		fatTblSpacing			= (0.056,0.064,0.12,0.6,0.7,
						   0.064,0.064,0.12,0.6,0.7,
						   0.12,0.12,0.12,0.6,0.7,
						   0.6,0.6,0.6,0.6,0.7,
						   0.7,0.7,0.7,0.7,0.7)
		minArea				= 0.016
		minEnclosedArea			= 0.2
}

LayerDataType		"M8DMY" {
		layerNumber			= 25
		dataTypeNumber			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "43"
		lineStyle			= "solid"
		pattern				= "brick"
}

Layer		"VIA8" {
		layerNumber			= 26
		maskName			= "via8"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "drab"
		lineStyle			= "solid"
		pattern				= "rectangleX"
		/*pitch				= 0.36*/
		defaultWidth			= 0.13
		minWidth			= 0.13
		minSpacing			= 0.12
		sameSegAlignedUpperWireMaxSpacingThreshold = 0.08
		sameSegAlignedLowerWireMaxSpacingThreshold = 0.08
		sameSegAlignedCutMinSpacing = 0.07
}

Layer		"M9" {
		layerNumber			= 27
		maskName			= "metal9"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "59"
		lineStyle			= "solid"
		pattern				= "rhidot"
		pitch				= 2.432
		defaultWidth			= 0.16
		minWidth			= 0.16
		minSpacing			= 0.16
		maxWidth			= 10
		fatTblDimension			= 3
		fatTblThreshold			= (0,0.501,1.701)
		fatTblParallelLength		= (0,0.501,1.701)
		fatTblSpacing			= (0.16,0.18,0.5,
						   0.18,0.18,0.5,
						   0.5,0.5,0.5)
		minArea				= 0.055
		minEnclosedArea			= 0.2
}

LayerDataType		"M9DMY" {
		layerNumber			= 27
		dataTypeNumber			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "59"
		lineStyle			= "solid"
		pattern				= "brick"
}

Layer		"CO" {
		layerNumber			= 28
		maskName			= "polyCont"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "white"
		lineStyle			= "solid"
		pattern				= "rectangleX"
		pitch				= 0
		defaultWidth			= 0.042
		minWidth			= 0.042
		minSpacing			= 0.05
		maxCurrDensity			= 701000
}

Layer		"HVTIMP" {
		layerNumber			= 29
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "orange"
		lineStyle			= "solid"
		pattern				= "zigzag"
		pitch				= 0
		defaultWidth			= 0.85
		minWidth			= 0.85
		minSpacing			= 0.85
}

Layer		"LVTIMP" {
		layerNumber			= 30
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "31"
		lineStyle			= "solid"
		pattern				= "zigzag"
		pitch				= 0
		defaultWidth			= 0.85
		minWidth			= 0.85
		minSpacing			= 0.85
}

Layer		"M1PIN" {
		layerNumber			= 31
		maskName			= "m1txt"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "white"
		lineStyle			= "solid"
		pattern				= "slash"
		pitch				= 0.01
		defaultWidth			= 0.01
		minWidth			= 0.01
		minSpacing			= 0.01
}

Layer		"M2PIN" {
		layerNumber			= 32
		maskName			= "m2txt"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "white"
		lineStyle			= "solid"
		pattern				= "slash"
		pitch				= 0.01
		defaultWidth			= 0.01
		minWidth			= 0.01
		minSpacing			= 0.01
}

Layer		"M3PIN" {
		layerNumber			= 33
		maskName			= "m3txt"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "white"
		lineStyle			= "solid"
		pattern				= "slash"
		pitch				= 0.01
		defaultWidth			= 0.01
		minWidth			= 0.01
		minSpacing			= 0.01
}

Layer		"M4PIN" {
		layerNumber			= 34
		maskName			= "m4txt"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "white"
		lineStyle			= "solid"
		pattern				= "slash"
		pitch				= 0.01
		defaultWidth			= 0.01
		minWidth			= 0.01
		minSpacing			= 0.01
}

Layer		"M5PIN" {
		layerNumber			= 35
		maskName			= "m5txt"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "white"
		lineStyle			= "solid"
		pattern				= "slash"
		pitch				= 0.01
		defaultWidth			= 0.01
		minWidth			= 0.01
		minSpacing			= 0.01
}

Layer		"M6PIN" {
		layerNumber			= 36
		maskName			= "m6txt"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "white"
		lineStyle			= "solid"
		pattern				= "slash"
		pitch				= 0.01
		defaultWidth			= 0.01
		minWidth			= 0.01
		minSpacing			= 0.01
}

Layer		"M7PIN" {
		layerNumber			= 37
		maskName			= "m7txt"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "white"
		lineStyle			= "solid"
		pattern				= "slash"
		pitch				= 0.01
		defaultWidth			= 0.01
		minWidth			= 0.01
		minSpacing			= 0.01
}

Layer		"M8PIN" {
		layerNumber			= 38
		maskName			= "m8txt"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "white"
		lineStyle			= "solid"
		pattern				= "slash"
		pitch				= 0.01
		defaultWidth			= 0.01
		minWidth			= 0.01
		minSpacing			= 0.01
}

Layer		"M9PIN" {
		layerNumber			= 39
		maskName			= "m9txt"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "white"
		lineStyle			= "solid"
		pattern				= "slash"
		pitch				= 0.01
		defaultWidth			= 0.01
		minWidth			= 0.01
		minSpacing			= 0.01
}

Layer		"MRDL" {
		layerNumber			= 41
		maskName			= "metal10"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "59"
		lineStyle			= "solid"
		pattern				= "solid"
		pitch				= 4.864
		defaultWidth			= 2
		minWidth			= 2
		minSpacing			= 2
		maxWidth			= 30
		minArea				= 4
		minEnclosedArea			= 0.2
}

Layer		"VIARDL" {
		layerNumber			= 42
		maskName			= "via9"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "drab"
		lineStyle			= "solid"
		pattern				= "rectangleX"
		pitch				= 0.36
		defaultWidth			= 2
		minWidth			= 2
		minSpacing			= 2
}

Layer		"MRDL9PIN" {
		layerNumber			= 43
		maskName			= "mrdl9txt"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "white"
		lineStyle			= "solid"
		pattern				= "slash"
		pitch				= 0.01
		defaultWidth			= 0.01
		minWidth			= 0.01
		minSpacing			= 0.01
}

Layer		"HOTNWL" {
		layerNumber			= 44
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "drab"
		lineStyle			= "solid"
		pattern				= "zigzag"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"DIOD" {
		layerNumber			= 46
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "white"
		lineStyle			= "solid"
		pattern				= "rectangleX"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"BJTDMY" {
		layerNumber			= 47
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "62"
		lineStyle			= "solid"
		pattern				= "rectangleX"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"RNW" {
		layerNumber			= 48
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "drab"
		lineStyle			= "solid"
		pattern				= "horizontal"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"RMARK" {
		layerNumber			= 49
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "58"
		lineStyle			= "solid"
		pattern				= "horizontal"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"prBoundary" {
		layerNumber			= 50
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "yellow"
		lineStyle			= "solid"
		pattern				= "dot"
		pitch				= 0
		defaultWidth			= 0.45
		minWidth			= 0.45
		minSpacing			= 0
}

Layer		"LOGO" {
		layerNumber			= 51
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "orange"
		lineStyle			= "solid"
		pattern				= "solid"
		pitch				= 0
		defaultWidth			= 0.45
		minWidth			= 0.45
		minSpacing			= 0.45
}

Layer		"IP" {
		layerNumber			= 52
		maskName			= "tag"
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "white"
		lineStyle			= "solid"
		pattern				= "slash"
		pitch				= 0.1
		defaultWidth			= 0.1
		minWidth			= 0.1
		minSpacing			= 0.1
}

Layer		"RM1" {
		layerNumber			= 53
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "25"
		lineStyle			= "solid"
		pattern				= "horizontal"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"RM2" {
		layerNumber			= 54
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "44"
		lineStyle			= "solid"
		pattern				= "horizontal"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"RM3" {
		layerNumber			= 55
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "31"
		lineStyle			= "solid"
		pattern				= "horizontal"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"RM4" {
		layerNumber			= 56
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "43"
		lineStyle			= "solid"
		pattern				= "horizontal"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"RM5" {
		layerNumber			= 57
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "40"
		lineStyle			= "solid"
		pattern				= "horizontal"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"RM6" {
		layerNumber			= 58
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "52"
		lineStyle			= "solid"
		pattern				= "horizontal"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"RM7" {
		layerNumber			= 59
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "orange"
		lineStyle			= "solid"
		pattern				= "horizontal"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"RM8" {
		layerNumber			= 60
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "36"
		lineStyle			= "solid"
		pattern				= "horizontal"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"RM9" {
		layerNumber			= 61
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "23"
		lineStyle			= "solid"
		pattern				= "horizontal"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"DM1EXCL" {
		layerNumber			= 64
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "drab"
		lineStyle			= "dash"
		pattern				= "enter"
		pitch				= 0
		defaultWidth			= 0.45
		minWidth			= 0.45
		minSpacing			= 0
}

Layer		"DM2EXCL" {
		layerNumber			= 65
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "28"
		lineStyle			= "solid"
		pattern				= "enter"
		pitch				= 0
		defaultWidth			= 0.45
		minWidth			= 0.45
		minSpacing			= 0
}

Layer		"DM3EXCL" {
		layerNumber			= 66
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "31"
		lineStyle			= "solid"
		pattern				= "enter"
		pitch				= 0
		defaultWidth			= 0.45
		minWidth			= 0.45
		minSpacing			= 0
}

Layer		"DM4EXCL" {
		layerNumber			= 67
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "43"
		lineStyle			= "solid"
		pattern				= "enter"
		pitch				= 0
		defaultWidth			= 0.45
		minWidth			= 0.45
		minSpacing			= 0
}

Layer		"DM5EXCL" {
		layerNumber			= 68
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "40"
		lineStyle			= "solid"
		pattern				= "enter"
		pitch				= 0
		defaultWidth			= 0.45
		minWidth			= 0.45
		minSpacing			= 0
}

Layer		"DM6EXCL" {
		layerNumber			= 69
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "52"
		lineStyle			= "solid"
		pattern				= "enter"
		pitch				= 0
		defaultWidth			= 0.45
		minWidth			= 0.45
		minSpacing			= 0
}

Layer		"DM7EXCL" {
		layerNumber			= 70
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "orange"
		lineStyle			= "solid"
		pattern				= "enter"
		pitch				= 0
		defaultWidth			= 0.45
		minWidth			= 0.45
		minSpacing			= 0
}

Layer		"DM8EXCL" {
		layerNumber			= 71
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "36"
		lineStyle			= "solid"
		pattern				= "enter"
		pitch				= 0
		defaultWidth			= 0.45
		minWidth			= 0.45
		minSpacing			= 0
}

Layer		"DM9EXCL" {
		layerNumber			= 72
		maskName			= ""
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "23"
		lineStyle			= "solid"
		pattern				= "enter"
		pitch				= 0
		defaultWidth			= 0.45
		minWidth			= 0.45
		minSpacing			= 0
}

Layer		"DIFF_25" {
		layerNumber			= 75
		maskName			= "25volt"
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "6"
		lineStyle			= "dot"
		pattern				= "zigzag"
		pitch				= 0
		defaultWidth			= 0.66
		minWidth			= 0.66
		minSpacing			= 0.66
}

Layer		"DIFF_FM" {
		layerNumber			= 100
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "40"
		lineStyle			= "solid"
		pattern				= "enter"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

Layer		"PO_FM" {
		layerNumber			= 101
		maskName			= ""
		isDefaultLayer			= 1
		visible				= 1
		selectable			= 1
		blink				= 0
		color				= "10"
		lineStyle			= "solid"
		pattern				= "enter"
		pitch				= 0
		defaultWidth			= 0
		minWidth			= 0
		minSpacing			= 0
}

ContactCode	"VIA12SQ_C" {
		contactCodeNumber		= 1
		cutLayer			= "VIA1"
		lowerLayer			= "M1"
		upperLayer			= "M2"
		isDefaultContact		= 1
		cutWidth			= 0.05
		cutHeight			= 0.05
		upperLayerEncWidth		= 0.005
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.07
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA12BAR_C" {
		contactCodeNumber		= 3
		cutLayer			= "VIA1"
		lowerLayer			= "M1"
		upperLayer			= "M2"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.005
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA12LG_C" {
		contactCodeNumber		= 4
		cutLayer			= "VIA1"
		lowerLayer			= "M1"
		upperLayer			= "M2"
		isDefaultContact		= 0
		cutWidth			= 0.1
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA12SQ" {
		contactCodeNumber		= 5
		cutLayer			= "VIA1"
		lowerLayer			= "M1"
		upperLayer			= "M2"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.05
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.07
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA12BAR" {
		contactCodeNumber		= 7
		cutLayer			= "VIA1"
		lowerLayer			= "M1"
		upperLayer			= "M2"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA12LG" {
		contactCodeNumber		= 8
		cutLayer			= "VIA1"
		lowerLayer			= "M1"
		upperLayer			= "M2"
		isDefaultContact		= 0
		cutWidth			= 0.1
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA23SQ_C" {
		contactCodeNumber		= 9
		cutLayer			= "VIA2"
		lowerLayer			= "M2"
		upperLayer			= "M3"
		isDefaultContact		= 1
		cutWidth			= 0.05
		cutHeight			= 0.05
		upperLayerEncWidth		= 0.005
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.07
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA23BAR_C" {
		contactCodeNumber		= 11
		cutLayer			= "VIA2"
		lowerLayer			= "M2"
		upperLayer			= "M3"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.005
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA23LG_C" {
		contactCodeNumber		= 12
		cutLayer			= "VIA2"
		lowerLayer			= "M2"
		upperLayer			= "M3"
		isDefaultContact		= 0
		cutWidth			= 0.1
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA23SQ" {
		contactCodeNumber		= 13
		cutLayer			= "VIA2"
		lowerLayer			= "M2"
		upperLayer			= "M3"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.05
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.07
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA23BAR" {
		contactCodeNumber		= 15
		cutLayer			= "VIA2"
		lowerLayer			= "M2"
		upperLayer			= "M3"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA23LG" {
		contactCodeNumber		= 16
		cutLayer			= "VIA2"
		lowerLayer			= "M2"
		upperLayer			= "M3"
		isDefaultContact		= 0
		cutWidth			= 0.1
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA34SQ_C" {
		contactCodeNumber		= 17
		cutLayer			= "VIA3"
		lowerLayer			= "M3"
		upperLayer			= "M4"
		isDefaultContact		= 1
		cutWidth			= 0.05
		cutHeight			= 0.05
		upperLayerEncWidth		= 0.005
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.07
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA34BAR_C" {
		contactCodeNumber		= 19
		cutLayer			= "VIA3"
		lowerLayer			= "M3"
		upperLayer			= "M4"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.005
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA34LG_C" {
		contactCodeNumber		= 20
		cutLayer			= "VIA3"
		lowerLayer			= "M3"
		upperLayer			= "M4"
		isDefaultContact		= 0
		cutWidth			= 0.1
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA34SQ" {
		contactCodeNumber		= 21
		cutLayer			= "VIA3"
		lowerLayer			= "M3"
		upperLayer			= "M4"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.05
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.07
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA34BAR" {
		contactCodeNumber		= 23
		cutLayer			= "VIA3"
		lowerLayer			= "M3"
		upperLayer			= "M4"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA34LG" {
		contactCodeNumber		= 24
		cutLayer			= "VIA3"
		lowerLayer			= "M3"
		upperLayer			= "M4"
		isDefaultContact		= 0
		cutWidth			= 0.1
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA45SQ_C" {
		contactCodeNumber		= 25
		cutLayer			= "VIA4"
		lowerLayer			= "M4"
		upperLayer			= "M5"
		isDefaultContact		= 1
		cutWidth			= 0.05
		cutHeight			= 0.05
		upperLayerEncWidth		= 0.005
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.07
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA45BAR_C" {
		contactCodeNumber		= 27
		cutLayer			= "VIA4"
		lowerLayer			= "M4"
		upperLayer			= "M5"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.005
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA45LG_C" {
		contactCodeNumber		= 28
		cutLayer			= "VIA4"
		lowerLayer			= "M4"
		upperLayer			= "M5"
		isDefaultContact		= 0
		cutWidth			= 0.1
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA45SQ" {
		contactCodeNumber		= 29
		cutLayer			= "VIA4"
		lowerLayer			= "M4"
		upperLayer			= "M5"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.05
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.07
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA45BAR" {
		contactCodeNumber		= 31
		cutLayer			= "VIA4"
		lowerLayer			= "M4"
		upperLayer			= "M5"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA45LG" {
		contactCodeNumber		= 32
		cutLayer			= "VIA4"
		lowerLayer			= "M4"
		upperLayer			= "M5"
		isDefaultContact		= 0
		cutWidth			= 0.1
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA56SQ_C" {
		contactCodeNumber		= 33
		cutLayer			= "VIA5"
		lowerLayer			= "M5"
		upperLayer			= "M6"
		isDefaultContact		= 1
		cutWidth			= 0.05
		cutHeight			= 0.05
		upperLayerEncWidth		= 0.005
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.07
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA56BAR_C" {
		contactCodeNumber		= 35
		cutLayer			= "VIA5"
		lowerLayer			= "M5"
		upperLayer			= "M6"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.005
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA56LG_C" {
		contactCodeNumber		= 36
		cutLayer			= "VIA5"
		lowerLayer			= "M5"
		upperLayer			= "M6"
		isDefaultContact		= 0
		cutWidth			= 0.1
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA56SQ" {
		contactCodeNumber		= 37
		cutLayer			= "VIA5"
		lowerLayer			= "M5"
		upperLayer			= "M6"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.05
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.07
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA56BAR" {
		contactCodeNumber		= 39
		cutLayer			= "VIA5"
		lowerLayer			= "M5"
		upperLayer			= "M6"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA56LG" {
		contactCodeNumber		= 40
		cutLayer			= "VIA5"
		lowerLayer			= "M5"
		upperLayer			= "M6"
		isDefaultContact		= 0
		cutWidth			= 0.1
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA67SQ_C" {
		contactCodeNumber		= 41
		cutLayer			= "VIA6"
		lowerLayer			= "M6"
		upperLayer			= "M7"
		isDefaultContact		= 1
		cutWidth			= 0.05
		cutHeight			= 0.05
		upperLayerEncWidth		= 0.005
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.07
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA67BAR_C" {
		contactCodeNumber		= 43
		cutLayer			= "VIA6"
		lowerLayer			= "M6"
		upperLayer			= "M7"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.005
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA67LG_C" {
		contactCodeNumber		= 44
		cutLayer			= "VIA6"
		lowerLayer			= "M6"
		upperLayer			= "M7"
		isDefaultContact		= 0
		cutWidth			= 0.1
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA67SQ" {
		contactCodeNumber		= 45
		cutLayer			= "VIA6"
		lowerLayer			= "M6"
		upperLayer			= "M7"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.05
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.07
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA67BAR" {
		contactCodeNumber		= 47
		cutLayer			= "VIA6"
		lowerLayer			= "M6"
		upperLayer			= "M7"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA67LG" {
		contactCodeNumber		= 48
		cutLayer			= "VIA6"
		lowerLayer			= "M6"
		upperLayer			= "M7"
		isDefaultContact		= 0
		cutWidth			= 0.1
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA78SQ_C" {
		contactCodeNumber		= 49
		cutLayer			= "VIA7"
		lowerLayer			= "M7"
		upperLayer			= "M8"
		isDefaultContact		= 1
		cutWidth			= 0.05
		cutHeight			= 0.05
		upperLayerEncWidth		= 0.005
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.07
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA78BAR_C" {
		contactCodeNumber		= 51
		cutLayer			= "VIA7"
		lowerLayer			= "M7"
		upperLayer			= "M8"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.005
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA78LG_C" {
		contactCodeNumber		= 52
		cutLayer			= "VIA7"
		lowerLayer			= "M7"
		upperLayer			= "M8"
		isDefaultContact		= 0
		cutWidth			= 0.1
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA78SQ" {
		contactCodeNumber		= 53
		cutLayer			= "VIA7"
		lowerLayer			= "M7"
		upperLayer			= "M8"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.05
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.07
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA78BAR" {
		contactCodeNumber		= 55
		cutLayer			= "VIA7"
		lowerLayer			= "M7"
		upperLayer			= "M8"
		isDefaultContact		= 0
		cutWidth			= 0.05
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA78LG" {
		contactCodeNumber		= 56
		cutLayer			= "VIA7"
		lowerLayer			= "M7"
		upperLayer			= "M8"
		isDefaultContact		= 0
		cutWidth			= 0.1
		cutHeight			= 0.1
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.005
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.005
		minCutSpacing			= 0.085
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA89_C" {
		contactCodeNumber		= 57
		cutLayer			= "VIA8"
		lowerLayer			= "M8"
		upperLayer			= "M9"
		isDefaultContact		= 1
		cutWidth			= 0.13
		cutHeight			= 0.13
		upperLayerEncWidth		= 0.015
		upperLayerEncHeight		= 0.03
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.015
		minCutSpacing			= 0.12
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA89" {
		contactCodeNumber		= 58
		cutLayer			= "VIA8"
		lowerLayer			= "M8"
		upperLayer			= "M9"
		isDefaultContact		= 1
		cutWidth			= 0.13
		cutHeight			= 0.13
		upperLayerEncWidth		= 0.03
		upperLayerEncHeight		= 0.015
		lowerLayerEncWidth		= 0.03
		lowerLayerEncHeight		= 0.015
		minCutSpacing			= 0.12
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}

ContactCode	"VIA9RDL" {
		contactCodeNumber		= 67
		cutLayer			= "VIARDL"
		lowerLayer			= "M9"
		upperLayer			= "MRDL"
		isDefaultContact		= 1
		cutWidth			= 2
		cutHeight			= 2
		upperLayerEncWidth		= 0.5
		upperLayerEncHeight		= 0.5
		lowerLayerEncWidth		= 0.5
		lowerLayerEncHeight		= 0.5
		minCutSpacing			= 2
		maxNumRowsNonTurning		= 4
		unitMinResistance		= 0.0008
		unitNomResistance		= 0.0016
		unitMaxResistance		= 0.0024
}


DesignRule	{
		layer1				= "VIA1"
		layer2				= "VIA1"
		cut1TblSize			= 3
		cut2TblSize			= 3
		cut1NameTbl			= (V1SQ, V1BAR, V1LG)
		cut2NameTbl			= (V1SQ, V1BAR, V1LG)
		sameNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
		diffNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
}

DesignRule	{
		layer1				= "VIA2"
		layer2				= "VIA2"
		cut1TblSize			= 3
		cut2TblSize			= 3
		cut1NameTbl			= (V2SQ, V2BAR, V2LG)
		cut2NameTbl			= (V2SQ, V2BAR, V2LG)
		sameNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
		diffNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
}

DesignRule	{
		layer1				= "VIA3"
		layer2				= "VIA3"
		cut1TblSize			= 3
		cut2TblSize			= 3
		cut1NameTbl			= (V3SQ, V3BAR, V3LG)
		cut2NameTbl			= (V3SQ, V3BAR, V3LG)
		sameNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
		diffNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
}

DesignRule	{
		layer1				= "VIA4"
		layer2				= "VIA4"
		cut1TblSize			= 3
		cut2TblSize			= 3
		cut1NameTbl			= (V4SQ, V4BAR, V4LG)
		cut2NameTbl			= (V4SQ, V4BAR, V4LG)
		sameNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
		diffNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
}

DesignRule	{
		layer1				= "VIA5"
		layer2				= "VIA5"
		cut1TblSize			= 3
		cut2TblSize			= 3
		cut1NameTbl			= (V5SQ, V5BAR, V5LG)
		cut2NameTbl			= (V5SQ, V5BAR, V5LG)
		sameNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
		diffNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
}

DesignRule	{
		layer1				= "VIA6"
		layer2				= "VIA6"
		cut1TblSize			= 3
		cut2TblSize			= 3
		cut1NameTbl			= (V6SQ, V6BAR, V6LG)
		cut2NameTbl			= (V6SQ, V6BAR, V6LG)
		sameNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
		diffNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
}

DesignRule	{
		layer1				= "VIA7"
		layer2				= "VIA7"
		cut1TblSize			= 3
		cut2TblSize			= 3
		cut1NameTbl			= (V7SQ, V7BAR, V7LG)
		cut2NameTbl			= (V7SQ, V7BAR, V7LG)
		sameNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
		diffNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
}

DesignRule	{
		layer1				= "VIA1"
		layer2				= "VIA2"
		stackable			= 1
		cut1TblSize			= 3
		cut2TblSize			= 3
		cut1NameTbl			= (V1SQ, V1BAR, V1LG)
		cut2NameTbl			= (V2SQ, V2BAR, V2LG)
		sameNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
		diffNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
}

DesignRule	{
		layer1				= "VIA2"
		layer2				= "VIA3"
		cut1TblSize			= 3
		cut2TblSize			= 3
		stackable			= 1
		cut1NameTbl			= (V2SQ, V2BAR, V2LG)
		cut2NameTbl			= (V3SQ, V3BAR, V3LG)
		sameNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
		diffNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
}

DesignRule	{
		layer1				= "VIA3"
		layer2				= "VIA4"
		cut1TblSize			= 3
		cut2TblSize			= 3
		stackable			= 1
		cut1NameTbl			= (V3SQ, V3BAR, V3LG)
		cut2NameTbl			= (V4SQ, V4BAR, V4LG)
		sameNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
		diffNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
}

DesignRule	{
		layer1				= "VIA4"
		layer2				= "VIA5"
		stackable			= 1
		cut1TblSize			= 3
		cut2TblSize			= 3
		cut1NameTbl			= (V4SQ, V4BAR, V4LG)
		cut2NameTbl			= (V5SQ, V5BAR, V5LG)
		sameNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
		diffNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
}

DesignRule	{
		layer1				= "VIA5"
		layer2				= "VIA6"
		stackable			= 1
		cut1TblSize			= 3
		cut2TblSize			= 3
		cut1NameTbl			= (V5SQ, V5BAR, V5LG)
		cut2NameTbl			= (V6SQ, V6BAR, V6LG)
		sameNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
		diffNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
}

DesignRule	{
		layer1				= "VIA6"
		layer2				= "VIA7"
		stackable			= 1
		cut1TblSize			= 3
		cut2TblSize			= 3
		cut1NameTbl			= (V6SQ, V6BAR, V6LG)
		cut2NameTbl			= (V7SQ, V7BAR, V7LG)
		sameNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
		diffNetXMinSpacingTbl		= (0.07, 0.08,  0.08, 
						   0.08, 0.085, 0.085,
						   0.08, 0.085, 0.085)
}

DesignRule	{
		layer1				= "VIA7"
		layer2				= "VIA8"
		stackable			= 1
}

DesignRule	{
		layer1				= "NWELL"
		layer2				= "PIMP"
		minEnclosure			= 0
}

DesignRule	{
		layer1				= "PO"
		layer2				= "DIFF"
		minSpacing			= 0.05
}

DesignRule	{
		layer1				= "DIFF"
		layer2				= "CO"
		minSpacing			= 0.04
}

DesignRule	{
		layer1				= "PO"
		layer2				= "CO"
		minSpacing			= 0.04
		minEnclosure			= 0.04
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.03
		endOfLineEncSideThreshold	= (0.05)
		endOfLineEncTbl			= (0.05)
}

DesignRule	{
		layer1				= "PIMP"
		layer2				= "NIMP"
		minSpacing			= 0.24
}

DesignRule	{
		layer1				= "M1"
		layer2				= "CO"
		minEnclosure			= 0.004
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.05
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.035)
}

DesignRule	{
		layer1				= "VIA1"
		layer2				= "CO"
		stackable			= 1
}

DesignRule	{
		layer1				= "M1"
		layer2				= "VIA1"
		minEnclosure			= 0.005
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)

}

DesignRule	{
		layer1				= "M2"
		layer2				= "VIA1"
		minEnclosure			= 0.005
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M2"
		layer2				= "VIA2"
		minEnclosure			= 0.005
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M3"
		layer2				= "VIA2"
		minEnclosure			= 0.005
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M3"
		layer2				= "VIA3"
		minEnclosure			= 0.005
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M4"
		layer2				= "VIA3"
		minEnclosure			= 0.005
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M4"
		layer2				= "VIA4"
		minEnclosure			= 0.005
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M5"
		layer2				= "VIA4"
		minEnclosure			= 0.005
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M5"
		layer2				= "VIA5"
		minEnclosure			= 0.005
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M6"
		layer2				= "VIA5"
		minEnclosure			= 0.005
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M6"
		layer2				= "VIA6"
		minEnclosure			= 0.005
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M7"
		layer2				= "VIA6"
		minEnclosure			= 0.005
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M7"
		layer2				= "VIA7"
		minEnclosure			= 0.005
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M8"
		layer2				= "VIA7"
		minEnclosure			= 0.005
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M8"
		layer2				= "VIA8"
		minEnclosure			= 0.015
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M9"
		layer2				= "VIA8"
		minEnclosure			= 0.015
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

DesignRule	{
		layer1				= "M9"
		layer2				= "VIARDL"
		minEnclosure			= 0.015
		endOfLineEncTblSize		= 1
		endOfLineEncWidthThreshold	= 0.06
		endOfLineEncSideThreshold	= (0.035)
		endOfLineEncTbl			= (0.03)
}

PRRule		{
		rowSpacingTopTop		= 0.56
		rowSpacingTopBot		= 0.28
		rowSpacingBotBot		= 0.56
		abuttableTopTop			= 1
		abuttableTopBot			= 0
		abuttableBotBot			= 1
}

DensityRule	{
		layer				= "M1"
		windowSize			= 75
		minDensity			= 10
		maxDensity			= 85
}

DensityRule	{
		layer				= "M1"
		windowSize			= 100
		minDensity			= 1
		maxDensity			= 60
}

DensityRule	{
		layer				= "M2"
		windowSize			= 50
		minDensity			= 15
		maxDensity			= 100
}

DensityRule	{
		layer				= "M2"
		windowSize			= 100
		minDensity			= 1
		maxDensity			= 70
}

DensityRule	{
		layer				= "M3"
		windowSize			= 50
		minDensity			= 15
		maxDensity			= 100
}

DensityRule	{
		layer				= "M3"
		windowSize			= 100
		minDensity			= 1
		maxDensity			= 70
}

DensityRule	{
		layer				= "M4"
		windowSize			= 50
		minDensity			= 15
		maxDensity			= 100
}

DensityRule	{
		layer				= "M4"
		windowSize			= 100
		minDensity			= 1
		maxDensity			= 70
}

DensityRule	{
		layer				= "M5"
		windowSize			= 50
		minDensity			= 15
		maxDensity			= 100
}

DensityRule	{
		layer				= "M5"
		windowSize			= 100
		minDensity			= 1
		maxDensity			= 70
}

DensityRule	{
		layer				= "M6"
		windowSize			= 50
		minDensity			= 15
		maxDensity			= 100
}

DensityRule	{
		layer				= "M6"
		windowSize			= 100
		minDensity			= 1
		maxDensity			= 70
}

DensityRule	{
		layer				= "M7"
		windowSize			= 50
		minDensity			= 15
		maxDensity			= 100
}

DensityRule	{
		layer				= "M7"
		windowSize			= 100
		minDensity			= 1
		maxDensity			= 70
}

DensityRule	{
		layer				= "M8"
		windowSize			= 50
		minDensity			= 15
		maxDensity			= 100
}

DensityRule	{
		layer				= "M8"
		windowSize			= 100
		minDensity			= 1
		maxDensity			= 70
}

DensityRule	{
		layer				= "M9"
		windowSize			= 50
		minDensity			= 15
		maxDensity			= 100
}

DensityRule	{
		layer				= "M9"
		windowSize			= 100
		minDensity			= 1
		maxDensity			= 60
}
