# ISIZE TECHNOLOGIES SA
# Mohamed Tahar Nguira, tahar.nguira@isize.co

#first task : 
#Define a function f(Path1, Path2,Path3, N) that returns 4 arrays A1, A2, B1, B2
#Path1 : Original video frames path
#Path2 : Isized Video frames path
#Path3 : Indicate path where user wants to put the Bic2Bic frames
#Jump : This function measures PSNR and SSIM once for each N frames
#A1  : PSNR table : Original frames -+> Iisized frames
#A2 : SSIM table : Original frames -+> Isized frames
#B1 : PSNR table : Original frames -+> Bic2Bic frames
#B2 : SSIM table : Original frames -+> Bic2Bic frames

# This function 
# - Creates a folder in Path3 and puts Bic2Bic(Original frames) inside this folder
# - Computes then the SSIM and PSNR metric tables between Original -+> Isized and Original -+> Bic2Bic
# return these arrays
import numpy as np
import time
import cv2
import skvideo.io
import skvideo.measure
t0= time.clock()
n_frames = 30
filename_original = "tiger_4k.mp4"
filename_isized = "tiger_4k_isize.mp4"
filename_bicubic = "tiger_4k_BIC.mp4"
video_original = skvideo.utils.rgb2gray(skvideo.io.vread(filename_original, num_frames=n_frames)) 
print("video1 read")
print(time.clock()-t0)
video_isized = skvideo.utils.rgb2gray(skvideo.io.vread(filename_isized, num_frames=n_frames))
print("video2 read")
print(time.clock()-t0)		
video_bicubic = skvideo.utils.rgb2gray(skvideo.io.vread(filename_bicubic, num_frames=n_frames))
print("video3 read")
print(time.clock()-t0)	
print("PSNR Isize")
y_array = (skvideo.measure.psnr(video_original, video_isized, bitdepth=8))
print(np.mean(y_array))
print("PSNR Bicubic")
y_array = (skvideo.measure.psnr(video_original, video_bicubic, bitdepth=8))
print(np.mean(y_array))
print("SSIM Isize")
y_array=(skvideo.measure.ssim(video_original, video_isized, bitdepth =8))
print(np.mean(y_array))
print("SSIM Bicubic")
y_array=(skvideo.measure.ssim(video_original, video_bicubic, bitdepth =8))
print(np.mean(y_array))
print("MSE Isize")
y_array=(skvideo.measure.mse(video_original, video_isized))
print(np.mean(y_array))
print("MSE Bicubic")
y_array=(skvideo.measure.mse(video_original, video_bicubic))
print(np.mean(y_array))
print(time.clock()-t0)
del(video_original)
del(video_isized)
del(video_bicubic)

