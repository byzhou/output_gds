%function parse(choice,plots)
choice = 1 ;
plots  = 0 ;
%choice 0 is standard choose file
%choice 1 is all files
%plots 0 is no plotting
%plots 1 is yes plotting

%fid = fopen('TLAT_X1.lef');
%fid = fopen('TBUF_X16.lef');
%fid = fopen('SDFFRS_X1.lef');
%fid = fopen('DFFRS_X1.lef');
%fid = fopen('SDFFR_X1.lef');
%fid = fopen('CLKGATETST_X1.lef');
tic
if choice
    %matfiles = dir(fullfile('*.lef'));
    matfiles = dir ( 'txt' ) ;
else
    matfiles=1;
end

%get rid of . and ..
for i=3:length(matfiles) 
    writex=[];
    writey=[];
    output=[];
    if plots
        figure(2);
        close 2;
        figure(3);
        close 3;
    end

    if choice
        if ~(strcmp ( matfiles(i).name , '.gitignore' ) ...
           || strcmp ( matfiles(i).name , '.' ) ...
           || strcmp ( matfiles(i).name , '..' ) )
            readFile    = strcat ( 'txt/' , matfiles(i).name ) ;
            disp ( readFile ) ;
            fid         = fopen ( readFile ) ;
        end
        %matfiles(i).name
    else
        %
        fid = fopen('txt/AND2_X1.txt');
        %
    end
    %count=0;
    if fid == -1
        disp('File open not successful')
    else
        while feof(fid) == 0
            % Read one line into a string variable
            aline = fgetl(fid);
            if length(aline)>14
                
                if aline(1:7)=='POLYGON'
                    saved=aline(9:end);
                    saved=str2num(saved);
                    disp ( saved ) ;
                    disp ( length ( saved ) ) ;
                    %count=count+1
                    disp ( ' pre square ' ) ;
                    [x,y,newx,newy,orderedvecx,orderedvecy,outputx,outputy]=square(saved,plots);
                    %input('Press Enter for next figure:');
                    disp ( ' post square ' ) ;
                    writex=[writex;outputx];
                    writey=[writey;outputy];
                end
            end
        end
%         if plots
%             saveas(2, 'compare1', 'png')
%             saveas(3, 'compare2', 'png')
%             compare1=imread('compare1.png');
%             compare2=imread('compare2.png');
%             gray1=rgb2gray(compare1);
%             gray2=rgb2gray(compare2);
%             for j=1:numel(gray1)
%                 if (gray1(j)==255)&&(gray2(j)<255)
%                     error('Figures Don''t Match');
%                 end
%                 if (gray2(j)==255)&&(gray1(j)<255)
%                     error('Figures Don''t Match');
%                 end
%             end
%             display('Area and Figures Match');
%         end
       
        %close read file  
        closeresult = fclose(fid);
        if closeresult == 0
            disp('File close successful')
        else
            disp('File close not successful')
        end

        [a,b]=size(writey);
        fprintf ( ' %5.2f %5.2f \n' , a , b ) ;
        
        %open the write file name according to what we've read
        string=matfiles(i).name;
        fileName =string(1:end-4)
        string=strcat('rect/',fileName ,'.txt');
        fid = fopen ( string , 'w' ) ;
        
        %just in case read operation is not successful
        if fid == -1 
            fprintf ( ' File %s was not opened successfully !\n' , fileName ) ;
        else
            for j = 1 : a
                % write the info of the first and the third number
                %fprintf ( fid , '%5.2f %5.2f %5.2f %5.2f \n' , wirtex ( j , 1 ) , writey ( j , 1 ) , wirtex ( j , 5 ) , writey ( j , 6 ) ) ;
            end
        end

        for j=1:a
            output(j,1)=writex(j,1);
            output(j,2)=writey(j,1);
            output(j,3)=writex(j,2);
            output(j,4)=writey(j,2);
            output(j,5)=writex(j,3);
            output(j,6)=writey(j,3);
            output(j,7)=writex(j,4);
            output(j,8)=writey(j,4);
            %disp ( output ( j , 1 ) ) ;
            fprintf ( fid , '%5.2f %5.2f %5.2f %5.2f \n' , writex ( j , 1 ) , writey ( j , 1 ) , writex ( j , 3 ) , writey ( j , 3 ) ) ;
        end
        %save('string','output','-ascii');
        
        %close read file  
        closeresult = fclose(fid);
        if closeresult == 0
            disp('File close successful')
        else
            disp('File close not successful')
        end

    end
end
toc
