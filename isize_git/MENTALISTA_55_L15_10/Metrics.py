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
from skimage import data
from skimage import measure
t0= time.clock()
filename1_isized = "000001_photo_scale.png"
filename1_original = "000001.png"
filename1_bicubic = "000001__bicubic.png"
filename2_isized = "000003_photo_scale.png"
filename2_original = "000003.png"
filename2_bicubic = "000003__bicubic.png"
filename3_isized = "000005_photo_scale.png"
filename3_original = "000005.png"
filename3_bicubic = "000005__bicubic.png"
filename4_isized = "000007_photo_scale.png"
filename4_original = "000007.png"
filename4_bicubic = "000007__bicubic.png"
filename5_isized = "000009_photo_scale.png"
filename5_original = "000009.png"
filename5_bicubic = "000009__bicubic.png"
filename6_isized = "000011_photo_scale.png"
filename6_original = "000011.png"
filename6_bicubic = "000011__bicubic.png"
filename7_isized = "000013_photo_scale.png"
filename7_original = "000013.png"
filename7_bicubic = "000013__bicubic.png"
filename8_isized = "000015_photo_scale.png"
filename8_original = "000015.png"
filename8_bicubic = "000015__bicubic.png"
filename9_isized = "000017_photo_scale.png"
filename9_original = "000017.png"
filename9_bicubic = "000017__bicubic.png"
filename10_isized = "000019_photo_scale.png"
filename10_original = "000019.png"
filename10_bicubic = "000019__bicubic.png"
image_original1 =data.imread(filename1_original)
image_isized1=data.imread(filename1_isized)
image_bicubic1=data.imread(filename1_bicubic)
image_original2 =data.imread(filename2_original)
image_isized2=data.imread(filename2_isized)
image_bicubic2=data.imread(filename2_bicubic)
image_original3 =data.imread(filename3_original)
image_isized3=data.imread(filename3_isized)
image_bicubic3=data.imread(filename3_bicubic)
image_original4 =data.imread(filename4_original)
image_isized4=data.imread(filename4_isized)
image_bicubic4=data.imread(filename4_bicubic)
image_original5 =data.imread(filename5_original)
image_isized5=data.imread(filename5_isized)
image_bicubic5=data.imread(filename5_bicubic)
image_original6 =data.imread(filename6_original)
image_isized6=data.imread(filename6_isized)
image_bicubic6=data.imread(filename6_bicubic)
image_original7 =data.imread(filename7_original)
image_isized7=data.imread(filename7_isized)
image_bicubic7=data.imread(filename7_bicubic)
image_original8 =data.imread(filename8_original)
image_isized8=data.imread(filename8_isized)
image_bicubic8=data.imread(filename8_bicubic)
image_original9 =data.imread(filename9_original)
image_isized9=data.imread(filename9_isized)
image_bicubic9=data.imread(filename9_bicubic)
image_original10 =data.imread(filename10_original)
image_isized10=data.imread(filename10_isized)
image_bicubic10=data.imread(filename10_bicubic)
print("--------------case1-------------------")
print("PSNR Isize")
print(measure.compare_psnr(image_original1, image_isized1))
print("PSNR Bicubic")
print(measure.compare_psnr(image_original1, image_bicubic1))
print("MSE Isize")
print(measure.compare_mse(image_original1, image_isized1))
print("MSE Bicubic")
print(measure.compare_mse(image_original1, image_bicubic1))
print("SSIM Isize")
print(measure.compare_ssim(image_original1, image_isized1, win_size=3))
print("SSIM Bicubic")
print(measure.compare_ssim(image_original1, image_bicubic1, win_size=3))
print("--------------case2-------------------")
print("PSNR Isize")
print(measure.compare_psnr(image_original2, image_isized2))
print("PSNR Bicubic")
print(measure.compare_psnr(image_original2, image_bicubic2))
print("MSE Isize")
print(measure.compare_mse(image_original2, image_isized2))
print("MSE Bicubic")
print(measure.compare_mse(image_original2, image_bicubic2))
print("SSIM Isize")
print(measure.compare_ssim(image_original2, image_isized2, win_size=3))
print("SSIM Bicubic")
print(measure.compare_ssim(image_original2, image_bicubic2, win_size=3))
print("--------------case3-------------------")
print("PSNR Isize")
print(measure.compare_psnr(image_original3, image_isized3))
print("PSNR Bicubic")
print(measure.compare_psnr(image_original3, image_bicubic3))
print("MSE Isize")
print(measure.compare_mse(image_original3, image_isized3))
print("MSE Bicubic")
print(measure.compare_mse(image_original3, image_bicubic3))
print("SSIM Isize")
print(measure.compare_ssim(image_original3, image_isized3, win_size=3))
print("SSIM Bicubic")
print(measure.compare_ssim(image_original3, image_bicubic3, win_size=3))
print("--------------case4-------------------")
print("PSNR Isize")
print(measure.compare_psnr(image_original4, image_isized4))
print("PSNR Bicubic")
print(measure.compare_psnr(image_original4, image_bicubic4))
print("MSE Isize")
print(measure.compare_mse(image_original4, image_isized4))
print("MSE Bicubic")
print(measure.compare_mse(image_original4, image_bicubic4))
print("SSIM Isize")
print(measure.compare_ssim(image_original4, image_isized4, win_size=3))
print("SSIM Bicubic")
print(measure.compare_ssim(image_original4, image_bicubic4, win_size=3))
print("--------------case5-------------------")
print("PSNR Isize")
print(measure.compare_psnr(image_original5, image_isized5))
print("PSNR Bicubic")
print(measure.compare_psnr(image_original5, image_bicubic5))
print("MSE Isize")
print(measure.compare_mse(image_original5, image_isized5))
print("MSE Bicubic")
print(measure.compare_mse(image_original5, image_bicubic5))
print("SSIM Isize")
print(measure.compare_ssim(image_original5, image_isized5, win_size=3))
print("SSIM Bicubic")
print(measure.compare_ssim(image_original5, image_bicubic5, win_size=3))
print("--------------case6-------------------")
print("PSNR Isize")
print(measure.compare_psnr(image_original6, image_isized6))
print("PSNR Bicubic")
print(measure.compare_psnr(image_original6, image_bicubic6))
print("MSE Isize")
print(measure.compare_mse(image_original6, image_isized6))
print("MSE Bicubic")
print(measure.compare_mse(image_original6, image_bicubic6))
print("SSIM Isize")
print(measure.compare_ssim(image_original6, image_isized6, win_size=3))
print("SSIM Bicubic")
print(measure.compare_ssim(image_original6, image_bicubic6, win_size=3))
print("--------------case7-------------------")
print("PSNR Isize")
print(measure.compare_psnr(image_original7, image_isized7))
print("PSNR Bicubic")
print(measure.compare_psnr(image_original7, image_bicubic7))
print("MSE Isize")
print(measure.compare_mse(image_original7, image_isized7))
print("MSE Bicubic")
print(measure.compare_mse(image_original7, image_bicubic7))
print("SSIM Isize")
print(measure.compare_ssim(image_original7, image_isized7, win_size=3))
print("SSIM Bicubic")
print(measure.compare_ssim(image_original7, image_bicubic7, win_size=3))
print("--------------case8-------------------")
print("PSNR Isize")
print(measure.compare_psnr(image_original8, image_isized8))
print("PSNR Bicubic")
print(measure.compare_psnr(image_original8, image_bicubic8))
print("MSE Isize")
print(measure.compare_mse(image_original8, image_isized8))
print("MSE Bicubic")
print(measure.compare_mse(image_original8, image_bicubic8))
print("SSIM Isize")
print(measure.compare_ssim(image_original8, image_isized8, win_size=3))
print("SSIM Bicubic")
print(measure.compare_ssim(image_original8, image_bicubic8, win_size=3))
print("--------------case9-------------------")
print("PSNR Isize")
print(measure.compare_psnr(image_original9, image_isized9))
print("PSNR Bicubic")
print(measure.compare_psnr(image_original9, image_bicubic9))
print("MSE Isize")
print(measure.compare_mse(image_original9, image_isized9))
print("MSE Bicubic")
print(measure.compare_mse(image_original9, image_bicubic9))
print("SSIM Isize")
print(measure.compare_ssim(image_original9, image_isized9, win_size=3))
print("SSIM Bicubic")
print(measure.compare_ssim(image_original9, image_bicubic9, win_size=3))
print("--------------case10-------------------")
print("PSNR Isize")
print(measure.compare_psnr(image_original10, image_isized10))
print("PSNR Bicubic")
print(measure.compare_psnr(image_original10, image_bicubic10))
print("MSE Isize")
print(measure.compare_mse(image_original10, image_isized10))
print("MSE Bicubic")
print(measure.compare_mse(image_original10, image_bicubic10))
print("SSIM Isize")
print(measure.compare_ssim(image_original10, image_isized10, win_size=3))
print("SSIM Bicubic")
print(measure.compare_ssim(image_original10, image_bicubic10, win_size=3))

