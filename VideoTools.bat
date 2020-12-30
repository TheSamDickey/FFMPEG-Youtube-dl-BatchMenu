@echo off
CALL:Menu

:Menu
cls
echo Menu
echo ----------------
echo 1 - Download Video
echo 2 - Download Playlist
echo 3 - Split Video into Images
echo 4 - Webm to MP4
echo 5 - Split MKV
echo 6 - MKV to MP4
echo 7 - Concat mkv
echo 8 - Images to Video
echo 9 - Next Menu
echo ----------------
echo. 
set /p input="Select an option: "
cls
if %input%==1 CALL:1
if %input%==2 CALL:2
if %input%==3 CALL:3
if %input%==4 CALL:4
if %input%==5 CALL:5
if %input%==6 CALL:6
if %input%==7 CALL:7
if %input%==8 CALL:8
if %input%==9 exit
pause
exit


:1
set /p url="Set target URL: "
.\youtube-dl -F "%url%"
set /p quality="Select quality format code: "
.\youtube-dl -f "%quality%" "%url%"
pause
CALL:Menu


:2
set /p url="Set target URL: "
.\youtube-dl.exe -f best --yes-playlist "%url%"
pause
CALL:Menu


:3
set /p url="Set target file name: "
set /p quality="Set quality (1-5): "
.\ffmpeg -i "%url%" -q:v 3 output/output_%%03d.jpg
echo Complete!
pause
CALL:Menu


:4
set /p url="Set target file: "
if %url%==all (CALL:4all) else (CALL:4target)

:4target
.\ffmpeg -i "%url%.mkv" -c copy -c:a aac -movflags +faststart %url%.mp4
.\ffmpeg -i %url% video.mp4
pause
CALL:Menu

:4all
FOR /F "tokens=*" %%G IN ('dir /b *.mkv') DO ffmpeg -i "%%G" -c copy -c:a aac -movflags +faststart "%%~nG.mp4"
pause
CALL:Menu


:5
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
CALL:Menu


:6
set /p url="Set target file: "
if %url%==all (CALL:6all) else (CALL:6target)

:6target
.\ffmpeg -i "%url%.mkv" -c copy -c:a aac -movflags +faststart %url%.mp4
.\ffmpeg -i %url% video.mp4
pause
CALL:Menu

:6all
FOR /F "tokens=*" %%G IN ('dir /b *.mkv') DO ffmpeg -i "%%G" -c copy -c:a aac -movflags +faststart "%%~nG.mp4"
pause
CALL:Menu


:7
echo Update/create files.txt
set /p instructions="Press i for instructions, or any other key to continue: "
if %instructions%==i (CALL:7instructions) else (CALL:7continue)

:7continue
.\ffmpeg -f concat -safe 0 -i files.txt -c copy output.mkv
pause
CALL:Menu

:7instructions
cls
echo Create files.txt
echo Example:
echo file 'one.mkv'
echo file 'two.mkv'
echo .
echo .
pause
CALL:7

:8
echo After placing all images into the input folder,
pause
.\ffmpeg -i input/img%%03d.png -c:v libx264 -vf fps=24 -pix_fmt yuv420p outPut.mp4
pause
CALL:Menu