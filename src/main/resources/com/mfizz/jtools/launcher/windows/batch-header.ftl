@setlocal ENABLEDELAYEDEXPANSION
@echo OFF

@REM
@REM Batch script to launch Java app ${config.name}
@REM
@REM Description: ${config.shortDescription}
@REM
@REM Auto generated by mfz-jtools-launcher.
@REM  Web: http://mfizz.com
@REM  Twitter: http://twitter.com/mfizz_inc
@REM

@REM
@REM settings
@REM

set LOG_DIR=${config.logDir!""}
set RUN_DIR=${config.runDir!""}

@REM
@REM constants
@REM

set NAME=${config.name}
set TYPE=${config.type}
set MAIN_CLASS=${config.mainClass}
set MIN_JAVA_VERSION=${config.minJavaVersion}
set WORKING_DIR_MODE=${config.workingDirMode}
set BIN_DIR=${config.binDir!""}
set LIB_DIR=${config.jarDir!""}
set APP_ARGS=${config.appArgs}
set JAVA_ARGS=${config.javaArgs}

@REM
@REM working directory setup
@REM

set INITIAL_WORKING_DIR=%CD%

SET SCRIPTPATH=%~dp0
SET SCRIPTPATH=%SCRIPTPATH:~0,-1%
set APP_HOME_REL=%SCRIPTPATH%\..
@REM echo app_home_relative %APP_HOME_REL%

@REM do we need to change the current working directory?
if %WORKING_DIR_MODE%==APP_HOME (
	@REM echo changing working dir to app_home
    pushd %APP_HOME_REL%
    set APP_HOME=.
) else (
    @REM echo temporarily change working directory to get good abs path
    pushd %APP_HOME_REL%
    set APP_HOME=!CD!
    echo app_home now !APP_HOME!
    popd
)

@REM setup remaining directories
set APP_BIN_DIR=%APP_HOME%\%BIN_DIR%
set APP_LOG_DIR=%APP_HOME%\%LOG_DIR%
set APP_LIB_DIR=%APP_HOME%\%LIB_DIR%
set APP_RUN_DIR=%APP_HOME%\%RUN_DIR%

if "%VERBOSE%"=="1" (
    echo working_dir: %CD%
    echo app_home: %APP_HOME%
    echo app_bin: %APP_BIN_DIR%
    echo app_log: %APP_LOG_DIR%
    echo app_lib: %APP_LIB_DIR%
    echo app_run: %APP_RUN_DIR%
)

set bit64=n
if /I %Processor_Architecture%==AMD64 set bit64=y
if /I "%PROCESSOR_ARCHITEW6432%"=="AMD64" set bit64=y
@REM echo bit64: %bit64%
