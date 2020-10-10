## Version: $Id$
##
######################################################################
##
### Commentary:
##
######################################################################
##
### Change Log:
##
######################################################################
##
### Code:

project(TDxCompanion)

## #################################################################
## Sources
## #################################################################

set(${PROJECT_NAME}_HEADERS
  TDxCompanionActionClassesMacro.h
  TDxCompanionActionExecutor.h
  TDxCompanionActionProtocol.h
  TDxCompanionClickAction.h
  TDxCompanionColorPickerAction.h
  TDxCompanionDoubleclickAction.h
  TDxCompanionDragDownAction.h
  TDxCompanionDragUpAction.h
  TDxCompanionExecutionOptions.h
  TDxCompanionKeyBaseAction.h
  TDxCompanionKeyDownAction.h
  TDxCompanionKeyDownUpBaseAction.h
  TDxCompanionKeyPressAction.h
  TDxCompanionKeyUpAction.h
  TDxCompanionKeycodeInformer.h
  TDxCompanionMouseBaseAction.h
  TDxCompanionMoveAction.h
  TDxCompanionOutputHandler.h
  TDxCompanionPrintAction.h
  TDxCompanionRightClickAction.h
  TDxCompanionTripleclickAction.h
  TDxCompanionTypeAction.h
  TDxCompanionWaitAction.h
  TDxCompanionWindow.h
  TDxDaemon.h)

set(${PROJECT_NAME}_SOURCES
  TDxCompanionActionExecutor.m
  TDxCompanionClickAction.m
  TDxCompanionColorPickerAction.m
  TDxCompanionDoubleclickAction.m
  TDxCompanionDragDownAction.m
  TDxCompanionDragUpAction.m
  TDxCompanionKeyBaseAction.m
  TDxCompanionKeyDownAction.m
  TDxCompanionKeyDownUpBaseAction.m
  TDxCompanionKeyPressAction.m
  TDxCompanionKeyUpAction.m
  TDxCompanionKeycodeInformer.m
  TDxCompanionMouseBaseAction.m
  TDxCompanionMoveAction.m
  TDxCompanionOutputHandler.m
  TDxCompanionPrintAction.m
  TDxCompanionRightClickAction.m
  TDxCompanionTripleclickAction.m
  TDxCompanionTypeAction.m
  TDxCompanionWaitAction.m
  TDxCompanionWindow.cpp
  TDxDaemon.cpp)

set(${PROJECT_NAME}_SOURCES ${${PROJECT_NAME}_SOURCES}
  main.mm)

set(${PROJECT_NAME}_SOURCES_QRC main.qrc)

set_property(SOURCE qrc_main.cpp PROPERTY SKIP_AUTOMOC ON)

## #################################################################
## Build rules
## #################################################################

qt5_add_resources(${PROJECT_NAME}_SOURCES_RCC ${${PROJECT_NAME}_SOURCES_QRC})

add_executable(${PROJECT_NAME}
  ${${PROJECT_NAME}_SOURCES_RCC}
  ${${PROJECT_NAME}_SOURCES}
  ${${PROJECT_NAME}_HEADERS})

target_link_libraries(${PROJECT_NAME} PRIVATE Qt5::Core)
target_link_libraries(${PROJECT_NAME} PRIVATE Qt5::Gui)
target_link_libraries(${PROJECT_NAME} PRIVATE Qt5::Widgets)

target_link_libraries(${PROJECT_NAME} PUBLIC "-framework AppKit")
target_link_libraries(${PROJECT_NAME} PUBLIC "-framework Cocoa")
target_link_libraries(${PROJECT_NAME} PUBLIC "-framework Carbon")
target_link_libraries(${PROJECT_NAME} PUBLIC ${3DCONNEXIONCLIENT_FRAMEWORK})

######################################################################
### CMakeLists.txt ends here
