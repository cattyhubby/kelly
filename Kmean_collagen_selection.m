%% Name:Kmean automatical selection
% Aug 2017
% Created by Yang
clc;clear all;close all

%% loading directory
sdirectory = 'C:\Users\Yang\Desktop\MT test';
source = 'C:\Users\Yang\Desktop\MT Result\';
tifffiles = dir([sdirectory '\*.tif']);
lenTiff = length(tifffiles);

%% loading and processing images
%count to load different sets of processed MT images
count=1; 

% change the interval value for different k-mean methods
for count=1:4:(lenTiff-3);
	filename1 = [sdirectory '\' tifffiles(count).name];
	filename2 = [sdirectory '\' tifffiles(count+1).name];
	filename3 = [sdirectory '\' tifffiles(count+2).name];
	filename4 = [sdirectory '\' tifffiles(count+3).name];
	I1 = imread(filename1);
	I2 = imread(filename2);
	I3 = imread(filename3);
	I4 = imread(filename4);

	% finding R channel images
	I11 = I1(:,:,1);
	I22 = I2(:,:,1);
	I33 = I3(:,:,1);
	I44 = I4(:,:,1);
	
	% calculating mean values for each images
	% using non-zero pixels only to exclude the background
	[row, col]=find(I11>0);
	index1=cat(2,row,col);
	leng1=length(row);
	sum1=0;
	sum1=double(sum1);
	for a=1:leng1;
		sum1=sum1+double(I11(index1(a,1),index1(a,2)));
	end
	value1=sum1/leng1;
	
	[row, col]=find(I22>0);
	index2=cat(2,row,col);
	leng2=length(row);
	sum2=0;
	sum2=double(sum2);
	for a=1:leng2;
		sum2=sum2+double(I22(index2(a,1),index2(a,2)));
	end
	value2=sum2/leng2;
	
	[row, col]=find(I33>0);
	index3=cat(2,row,col);
	leng3=length(row);
	sum3=0;
	sum3=double(sum3);
	for a=1:leng3;
		sum3=sum3+double(I33(index3(a,1),index3(a,2)));
	end
	value3=sum3/leng3;
	
	[row, col]=find(I44>0);
	index4=cat(2,row,col);
	leng4=length(row);
	sum4=0;
	sum4=double(sum4);
	for a=1:leng4;
		sum4=sum4+double(I44(index4(a,1),index4(a,2)));
	end
	value4=sum4/leng4;
	
	% conclusion: the collagen is the 3rd one in R channel
	% save the corresponding images for collagen
	allvalues=cat(2,value1,value2,value3,value4);
	order=sort(allvalues);
	if order(1,3)==value1;
		imwrite(I1,[source,'kmean_collagen_',num2str(count),'.tif'])
		else
		if order(:,3)==value2;
			imwrite(I2,[source,'kmean_collagen_',num2str(count),'.tif'])
			else
			if order(:,3)==value3;
				imwrite(I3,[source,'kmean_collagen_',num2str(count),'.tif'])
				else
				imwrite(I4,[source,'kmean_collagen_',num2str(count),'.tif'])
			end
		end
	end
		
	

	
end









