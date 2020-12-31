@echo off
goto:Menu

:Menu
cls
echo Menu
echo.
echo ----------------
echo 1 - Download Video
echo 2 - Download YT Playlist
echo 3 - MP4 + M4A
echo 4 - Webm to MP4
echo 5 - MKV to MP4
echo 6 - Split MKV
echo 7 - Concat mkv
echo 8 - 
echo 9 - Next Menu
echo ----------------
echo. 
set /p input="Select an option: "
cls
if %input%==1 goto:1
if %input%==2 goto:2
if %input%==3 goto:3
if %input%==4 goto:4
if %input%==5 goto:5
if %input%==6 goto:6
if %input%==7 goto:7
if %input%==8 goto:8
if %input%==9 exit
pause
exit

:Menu2
cls
echo Menu
echo.
echo ----------------
echo 1 - Split Video into Images
echo 2 - Images to Video
echo 3 - 
echo 4 - 
echo 5 -
echo 6 -
echo 7 -
echo 8 - Previous Menu
echo 9 -
echo ----------------
echo. 
set /p input="Select an option: "
cls
if %input%==1 goto:2-1
if %input%==2 goto:2-2
if %input%==3 exit
if %input%==4 exit
if %input%==5 exit
if %input%==6 exit
if %input%==7 exit
if %input%==8 exit
if %input%==9 exit
pause
exit


:1
set /p url="Set target URL: "
.\youtube-dl -F "%url%"
echo.
echo -----------------
echo 1 - Single file
echo 2 - Audio + Video
echo 3 - Cancel
echo -----------------
echo.
set /p option="Choose an option: "
if %option%==1 goto:111
if %option%==2 goto:112
if %option%==3 goto:Menu


:111
echo.
echo.
echo -----------------
set /p quality="Format code: "
.\youtube-dl -f "%quality%" "%url%"
pause
goto:Menu

:112
echo.
echo -------------------------------
echo 1 - MP4 Video + M4A Audio
echo 2 - Webm Video + M4A Audio
echo 3 - MP4 Video + Webm Audio
echo 4 - Webm Video + Webm Audio
echo -------------------------------
echo.
set /p option="Choose an option: "
if %option%==1 goto:1121
if %option%==2 goto:1-1-2-2
if %option%==3 goto:1123
if %option%==4 goto:1124

:1121
echo.
echo.
set /p video="Enter MP4 Video Format Code: "
set /p audio="Enter M4A Audio Format Code: "
echo You can ignore the following lines of code:
mkdir temp
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO move "%%G" "temp/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp4') DO move "%%G" "temp/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.m4a') DO move "%%G" "temp/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp3') DO move "%%G" "temp/%%G"
.\youtube-dl -f "%video%" "%url%"
.\youtube-dl -f "%audio%" "%url%"
mkdir input
FOR /F "tokens=*" %%G IN ('dir /b *.mp4') DO move "%%G" "input/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.m4a') DO move "%%G" "input/%%G"
cd input
ren *.mp4 input.mp4
ren *.m4a input.m4a
cd ../
ffmpeg -i input/input.mp4 -i input/input.M4A -c:v copy -c:a aac output.mp4
cd input
del input.mp4
del input.m4a
cd ../
mkdir output
move output.mp4 output/output.mp4
cd temp
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO move "%%G" "../%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp4') DO move "%%G" "../%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.m4a') DO move "%%G" "../%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp3') DO move "%%G" "../%%G"
cd ../
pause
goto:Menu

:1-1-2-2
echo.
echo.
set /p video="Enter Webm Video Format Code: "
set /p audio="Enter M4A Audio Format Code: "
echo You can ignore the following lines of code:
mkdir temp
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO move "%%G" "temp/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp4') DO move "%%G" "temp/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.m4a') DO move "%%G" "temp/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp3') DO move "%%G" "temp/%%G"
.\youtube-dl -f "%video%" "%url%"
.\youtube-dl -f "%audio%" "%url%"
echo converting webm to mp4
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO ffmpeg -i "%%G" -c:v copy "%%~nG.mp4"
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO del "%%G"
mkdir input
FOR /F "tokens=*" %%G IN ('dir /b *.mp4') DO move "%%G" "input/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.m4a') DO move "%%G" "input/%%G"
cd input
ren *.mp4 input.mp4
ren *.m4a input.m4a
cd ../
ffmpeg -i input/input.mp4 -i input/input.M4A -c:v copy -c:a aac output.mp4
cd input
del input.mp4
del input.m4a
cd ../
mkdir output
move output.mp4 output/output.mp4
cd temp
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO move "%%G" "../%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp4') DO move "%%G" "../%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.m4a') DO move "%%G" "../%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp3') DO move "%%G" "../%%G"
cd ../
pause
goto:Menu

:1123
echo.
echo.
set /p video="Enter MP4 Video Format Code: "
set /p audio="Enter Webm Audio Format Code: "
echo You can ignore the following lines of code:
mkdir temp
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO move "%%G" "temp/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp4') DO move "%%G" "temp/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.m4a') DO move "%%G" "temp/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp3') DO move "%%G" "temp/%%G"
.\youtube-dl -f "%video%" "%url%"
.\youtube-dl -f "%audio%" "%url%"
echo converting webm to mp3
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO ffmpeg -i "%%G" -c:v copy "%%~nG.mp3"
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO del "%%G"
mkdir input
FOR /F "tokens=*" %%G IN ('dir /b *.mp4') DO move "%%G" "input/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp3') DO move "%%G" "input/%%G"
cd input
ren *.mp4 input.mp4
ren *.mp3 input.mp3
cd ../
ffmpeg -i input/input.mp4 -i input/input.mp3 -c:v copy -c:a aac output.mp4
cd input
del input.mp4
del input.mp3
cd ../
mkdir output
move output.mp4 output/output.mp4
cd temp
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO move "%%G" "../%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp4') DO move "%%G" "../%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.m4a') DO move "%%G" "../%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp3') DO move "%%G" "../%%G"
cd ../
pause
goto:Menu

:1124
echo.
echo.
set /p video="Enter Webm Video Format Code: "
set /p audio="Enter Webm Audio Format Code: "
echo You can ignore the following lines of code:
mkdir temp
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO move "%%G" "temp/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp4') DO move "%%G" "temp/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.m4a') DO move "%%G" "temp/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp3') DO move "%%G" "temp/%%G"
.\youtube-dl -f "%audio%" "%url%"
echo converting webm to mp3
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO ffmpeg -i "%%G" -c:v copy "%%~nG.mp3"
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO del "%%G"
.\youtube-dl -f "%video%" "%url%"
echo converting webm to mp4
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO ffmpeg -i "%%G" -c:v copy "%%~nG.mp4"
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO del "%%G"
mkdir input
FOR /F "tokens=*" %%G IN ('dir /b *.mp4') DO move "%%G" "input/%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp3') DO move "%%G" "input/%%G"
cd input
ren *.mp4 input.mp4
ren *.mp3 input.mp3
cd ../
ffmpeg -i input/input.mp4 -i input/input.mp3 -c:v copy -c:a aac output.mp4
cd input
del input.mp4
del input.mp3
cd ../
mkdir output
move output.mp4 output/output.mp4
cd temp
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO move "%%G" "../%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp4') DO move "%%G" "../%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.m4a') DO move "%%G" "../%%G"
FOR /F "tokens=*" %%G IN ('dir /b *.mp3') DO move "%%G" "../%%G"
cd ../
pause
goto:Menu


:2
set /p url="Set target URL: "
.\youtube-dl.exe -f best --yes-playlist "%url%"
pause
goto:Menu

:3
echo Put MP4 and M4A into a folder gotoed input
pause
cd input
ren *.mp4 input.mp4
ren *.m4a input.m4a
cd ../
ffmpeg -i input/input.mp4 -i input/input.M4A -c:v copy -c:a aac output.mp4
mkdir output
move output.mp4 output/output.mp4
pause
goto:Menu


:4
set /p url="Enter filename (or do all): "
if %url%==all (goto:4all) else (goto:4target)

:4target
.\ffmpeg -i "%url%.webm" -max_muxing_queue_size 23387080 %url%.mp4
del "%url%.webm%
pause
goto:Menu

:4all
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO ffmpeg -i "%%G" -c:v copy "%%~nG.mp4"
FOR /F "tokens=*" %%G IN ('dir /b *.webm') DO del "%%G"
pause
goto:Menu


:5
set /p url="Enter filename (or do all): "
if %url%==all (goto:5all) else (goto:5target)

:5target
.\ffmpeg -i "%url%.mkv" -c copy -c:a aac -movflags +faststart %url%.mp4
del "%url%.mkv%
pause
goto:Menu

:5all
FOR /F "tokens=*" %%G IN ('dir /b *.mkv') DO ffmpeg -i "%%G" -c copy -c:a aac -movflags +faststart "%%~nG.mp4"
FOR /F "tokens=*" %%G IN ('dir /b *.mkv') DO del "%%G"
pause
goto:Menu


:6
set /p url="Set target file: "
set /p splitTime="Enter time to split:" 
echo Stripping subtitles...
ffmpeg -i "%url%" -vcodec copy -acodec copy -sn "nosubs.mkv"
echo splitting from beginning to %splitTime%
ffmpeg -i nosubs.mkv -ss 00:00:00 -t %splitTime% -c copy part1.mkv
echo splitting from %splitTime% to end...
ffmpeg -i nosubs.mkv -ss %splitTime% -c copy part2.mkv
echo removing nosubs...
del nosubs.mkv
echo done!
pause
goto:Menu


:7
echo Update/create files.txt
set /p instructions="Press i for instructions, or any other key to continue: "
if %instructions%==i (goto:7instructions) else (goto:7continue)

:7continue
.\ffmpeg -f concat -safe 0 -i files.txt -c copy output.mkv
pause
goto:Menu

:7instructions
cls
echo Create files.txt
echo Example:
echo file 'one.mkv'
echo file 'two.mkv'
echo .
echo .
pause
goto:7


:2-1
set /p url="Set target file name: "
set /p quality="Set quality (1-5): "
mkdir output
.\ffmpeg -i "%url%" -q:v 3 output/output_%%03d.jpg
echo Complete!
pause
goto:Menu


:2-2
echo After placing all images into the input folder,
pause
.\ffmpeg -i input/img%%03d.png -c:v libx264 -vf fps=24 -pix_fmt yuv420p outPut.mp4
pause
goto:Menu