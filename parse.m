%fid = fopen('TLAT_X1.lef');
%fid = fopen('TBUF_X16.lef');
%fid = fopen('SDFFRS_X1.lef');
%fid = fopen('DFFRS_X1.lef');
%fid = fopen('SDFFR_X1.lef');
%fid = fopen('CLKGATETST_X1.lef');
figure(2);
close 2;
clear all;
tic
fid = fopen('SDFFRS_X2.lef');
%count=0;
if fid == -1
    disp('File open not successful')
else
    while feof(fid) == 0
        % Read one line into a string variable
        aline = fgetl(fid);
        if length(aline)>14
            
            if aline(9:15)=='POLYGON'
                saved=aline(17:end);
                saved=str2num(saved);
                %count=count+1
                square(saved);
                input('Press Enter for next figure:');
            end
        end
    end
    closeresult = fclose(fid);
    if closeresult == 0
        disp('File close successful')
    else
        disp('File close not successful')
    end
end
toc