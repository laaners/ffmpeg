# ffmpeg and yt-dlp utils batches

Batches I made implementing custom ffmpeg and yt-dlp

Quite the spaghetti code, mostly for personal archive

Prerequisities: [ffmpeg ](https://github.com/FFmpeg/FFmpeg) and [yt-dlp](https://github.com/yt-dlp/yt-dlp), preferably added to path

## Batches
```bash
# Create a frames folder containing all frames of the video
C:\folder>frames "video"

# Uses -f concat -safe to join all the videos/audios in the selected folder, default extension .mp4
C:\folder>joiner "folder_name" [.ext]

# In a folder with various subfolders of the beforementioned kind, joins all videos/audios of subfolders creating videos/audios for each subfolders
C:\folder_with_subfolders>joinersubdiv

# In a folder with various subfolders of the beforementioned kind, joins all videos/audios of subfolders creating videos/audios for each subfolders
C:\folder_with_subfolders>joinersubdiv

# Cuts a video file according to timestamps specified in a .txt file, splitter -h for more info
C:\folder_with_subfolders>splitter -h

# Removes all video parts with audio below a certain threshold, needs .jar files support, silencer -h for more info
C:\folder_with_subfolders>silencer -h

# Sums all times or timestamps in a .txt file, timesum -h for more info
C:\folder_with_subfolders>timesum -h

# Downloads directly the clips specified by a .txt file from a downloadable video with yt-dlp, timestamps specified in [hh:]mm:ss-[hh:]mm:ss
C:\folder_with_subfolders>ytsplitter "video_url" "timestamps.txt"

# Downloads file with aria2c by specifying only yt-dlp options
C:\folder_with_subfolders>zaria2c "-f 248+140 video_url"

# Batch for elgato 60HD recording/streaming, elgato -h for more info
C:\folder_with_subfolders>elgato -h
```