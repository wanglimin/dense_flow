
function [] = extractOpticalFlow_gpu(index, device_id, type)
path1 = '/media/sdg/lmwang/Data/UCF101/ucf101_org/';
if type ==0
    path2 = '/media/sdb/lmwang/data/UCF101/ucf101_flow_img_farn_gpu_step_2/';
elseif type ==1
    path2 = '/media/sdg/lmwang/data/UCF101/ucf101_flow_img_tvl1_gpu_size_342/';
else
    path2 = '/media/sdb/lmwang/data/UCF101/ucf101_flow_img_brox_gpu_step_2/';
end

device_id = 1; type = 1;
fid = fopen('anet_8_1.cmd','w');
path1 = '/nfs_c06/Datasets/ActivityNet/anet_clips_v1.3/';
path2 = '/nfs_c06/Datasets/ActivityNet/anet_clips_v1.3_flow_img_fvl1_gpu_size_256/';
path3 = '/nfs_c06/Datasets/ActivityNet/anet_clips_v1.3_rgb_img_new_size_256/';
filelist = dir([path1,'*.avi']);
index = device_id*5000+1:(device_id+1)*5000;

for i =2014
    if ~exist([path2,filelist(i).name(1:end-4)],'dir')
        mkdir([path2,filelist(i).name(1:end-4)]);
    end
    if ~exist([path3,filelist(i).name(1:end-4)],'dir')
        mkdir([path3,filelist(i).name(1:end-4)]);
    end
    file1 = [path1,filelist(i).name];
    file2 = [path2,filelist(i).name(1:end-4),'/','flow_x'];
    file3 = [path2,filelist(i).name(1:end-4),'/','flow_y'];
    file4 = [path3,filelist(i).name(1:end-4),'/','image'];
%     cmd = sprintf('build/denseFlow_gpu -f %s -x %s -y %s -i %s -b 20 -t %d -d %d -s %d',...
%        file1,file2,file3,file4,type,device_id,1);
    cmd = sprintf('build/denseImage -f %s -i %s',...
        file1,file4);
    fprintf(fid,'%s\n', cmd);
end
fclose(fid);

path = '/nfs_c06/Datasets/ActivityNet/anet_clips_v1.3_rgb_img_size_256/';
folderlist = dir(path);
foldername = {folderlist(:).name};
foldername = setdiff(foldername,{'.','..'});
duration = zeros(1, length(foldername));
for i = 1:length(foldername)
    duration(i) = length(dir([path, foldername{i}, '/*.jpg']));
end


% path1 = '/nfs/lmwang/lmwang/Data/HMDB51/hmdb51_org/';
% if type ==0
%     path2 = '/media/sdb/lmwang/data/HMDB51/hmdb51_flow_img_farn_gpu/';
% elseif type ==1
%     path2 = '/media/sdb/lmwang/data/HMDB51/hmdb51_flow_img_tvl1_gpu/';
% else
%     path2 = '/media/sdb/lmwang/data/HMDB51/hmdb51_flow_img_brox_gpu/';
% end

folderlist = dir(path1);
foldername = {folderlist(:).name};
foldername = setdiff(foldername,{'.','..'});
fid = fopen('anet_1_1.cmd','w');
for i = 3175:5000
    if ~exist([path2,foldername{i}],'dir')
        mkdir([path2,foldername{i}]);
    end
    filelist = dir([path1,foldername{i},'/*.avi']);
    
    for j = 1:length(filelist)
        if ~exist([path2,foldername{i},'/',filelist(j).name(1:end-4)],'dir')
            mkdir([path2,foldername{i},'/',filelist(j).name(1:end-4)]);
        end
        file1 = [path1,foldername{i},'/',filelist(j).name];
        file2 = [path2,foldername{i},'/',filelist(j).name(1:end-4),'/','flow_x'];
        file3 = [path2,foldername{i},'/',filelist(j).name(1:end-4),'/','flow_y'];
        file4 = [path2,foldername{i},'/',filelist(j).name(1:end-4),'/','flow_i'];
        cmd = sprintf('./build/denseFlow_gpu -f %s -x %s -y %s -i %s -b 20 -t %d -d %d -s %d',...
            file1,file2,file3,file4,type,device_id,1);
        fprintf(fid,'%s\n', cmd);
    end
    i
end
fclose(fid);
end