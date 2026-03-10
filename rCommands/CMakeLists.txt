include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include
		            ${CMAKE_CURRENT_SOURCE_DIR}/../VDBlib/include
		            ${CMAKE_CURRENT_SOURCE_DIR}/../CMlib/include
		            ${CMAKE_CURRENT_SOURCE_DIR}/../DBlib/include
		            ${CMAKE_CURRENT_SOURCE_DIR}/../RGlib/include
		            ${CMAKE_CURRENT_SOURCE_DIR}/../MFlib/include)

foreach(loop_var ds2rgis dsAggregate dsClimatology dsDuration dsSampling dsStorage getHeader grdAppendLayers grdBoxAggr grdCalculate grdCellStats grdCreateNetwork
grdCycleMean grdDateLayers grdDifference grdExtractLayers grdHeatIndex grdImport grdMerge grdMinMax grdNetFilter grdNoNeg grdOperation grdReclassDisc  grdRemovePits grdRenameLayers grdRunningMean
grdSeasonAggr grdSeasonMean grdTimeSeries grdTSAggr grdZoneHist grdZoneStats netAccumulate netBasinDistrib netBasinHist netBasinProf netBasinStats netBuild
netcdf2ds netcdf2rgis netCells2Grid netCellSearch netCellSlopes netConfluence netCreatePnts netDefragment netErosion netImportASCII netInvAccum netStreamlines netSubset netTransfer
netPourElevation netPotReservoir netTrim netUnaccumulate netUpstreamAvg pntGridSampling pntGridValue pntStationDist pntSTNChar pntSTNCoord pntSubbasCenter pntSubbasHist pntSubbasins pntSubbasStats
pntSymbolField rgis2ascii rgis2domain rgis2ds rgis2netcdf rgis2mapper rgis2shp rgis2sql rgis2table rgisMetadb setHeader setProperties table2rgis tblAddField tblAddID tblAddXY tblCalculate tblConv2Point
tblConvCoord tblDecimalDate tblDeleteField tblDeleteRec tblIdleRec tblJoinTables tblMergeCoord tblMergeDate tblMJoinTables tblRedefField tblSelectRec vdbLookup
tblSortRec tblSplitDate tblStatistics tblTopoCalc )
	add_executable(${loop_var} src/CMD${loop_var}.cpp)
	target_link_libraries(${loop_var} LINK_PUBLIC VDB30 RG30 MF30 DB30 CM30 -lnetcdf -ludunits2 -lshp -lm -pthread)
	install (TARGETS ${loop_var} RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}/ghaas)
endforeach(loop_var)
