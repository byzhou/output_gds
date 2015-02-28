function [x,y,newx,newy,orderedvecx,orderedvecy,outputx,outputy]=square(z,plots)
%function [x,y,newx,newy,orderedvecx,orderedvecy,outputx,outputy]=square(z)
%z is just the vector of unparsed coordinates from lef file
%plots 0 is no plotting
%plots 1 is yes plotting

%EXAMPLE: original lef coordinates
%       LAYER metal1 ;
%         POLYGON 0.04 0.15 0.135 0.15 0.135 0.365 0.445 0.365 0.445 0.15 0.525 0.15 0.525 0.365 0.755 0.365 0.755 0.5 0.685 0.5 0.685 0.435 0.11 0.435 0.11 1.02 0.135 1.02 0.135 1.155 0.04 1.155  ;

%input this into matlab:
%z=[0.04 0.15 0.135 0.15 0.135 0.365 0.445 0.365 0.445 0.15 0.525 0.15
%0.525 0.365 0.755 0.365 0.755 0.5 0.685 0.5 0.685 0.435 0.11 0.435 0.11 1.02 0.135 1.02 0.135 1.155 0.04 1.155]

%call like this [a,b,c,d]=square(z)
%x and y are the original x,y coordinates of lef file, newx and newy are
%new coordinates added to aid in finding rectangles

%close all figures
if plots
    figure(1);
    close 1;
end
newx=[];
newy=[];

%parse z into x and y and plot
z_length=length(z);
for i=1:z_length/2
    y(i)=z(2*i);
    x(i)=z(2*i-1);
end
%figure(1);
if plots
    figure('units','normalized','outerposition',[0 0 1 1])
    subplot(2,2,1);
    plot(x,y,'*')
    axis equal;
    title('given')
    hold on
    plot(x,y)
end
A = polyarea(x,y);
B = 0;

%figure(2);
if plots
    subplot(2,2,2);
    fill(x,y,'b');
    string=sprintf('Area = %f',A);
    title(string);
    axis equal;
    figure(3)
    fill(x,y,'b');
    hold on;
    axis equal;
    figure(1);
end

yup=unique(y);
ydown=fliplr(yup);
xright=unique(x);
xleft=fliplr(xright);
%count for new points
orderedcount=1;
count=1;

outputcount=0;

%go through all the sides one by one and subdivide
for i=1:z_length/2 %number of points
    comp1=[x(i),y(i)];
    orderedvecx(orderedcount)=comp1(1);
    orderedvecy(orderedcount)=comp1(2);
    orderedcount=orderedcount+1;
    if i+1>z_length/2
        comp2=[x(1),y(1)];
    else
        comp2=[x(i+1),y(i+1)];
    end
    
    %if line is parallel to y axis
    if comp1(1)==comp2(1)
        if comp1(2)>comp2(2)
            dummy=ydown;
        else
            dummy=yup;
        end
        for i=1:length(dummy)
            if (min(comp1(2),comp2(2))<dummy(i))&(dummy(i)<max(comp1(2),comp2(2)))
                newx(count)=comp1(1);
                newy(count)=dummy(i);
                count=count+1;
                orderedvecx(orderedcount)=comp1(1);
                orderedvecy(orderedcount)=dummy(i);
                orderedcount=orderedcount+1;
            end
        end
    end
    
    %if line is parallel to x axis
    if comp1(2)==comp2(2)
        if comp1(1)>comp2(1)
            dummy=xleft;
        else
            dummy=xright;
        end
        for i=1:length(dummy)
            if (min(comp1(1),comp2(1))<dummy(i))&(dummy(i)<max(comp1(1),comp2(1)))
                newx(count)=dummy(i);
                newy(count)=comp1(2);
                count=count+1;
                orderedvecx(orderedcount)=dummy(i);
                orderedvecy(orderedcount)=comp1(2);
                orderedcount=orderedcount+1;
            end
        end
    end
end


%figure(3);
if plots
    subplot(2,2,3);
    plot(newx,newy,'o')
    axis equal;
    hold on;
    plot(x,y,'*')
    title('result')
    plot(x,y)
end


%figure(4);
if plots
    subplot(2,2,4);
    %plot(orderedvecx,orderedvecy,'*')
    hold on;
end

gcountx=1;
gcounty=1;
innerpcount=1;
innerpointsx=[];
innerpointsy=[];
for i=1:length(orderedvecx)
    if ~isempty(min(orderedvecx(find(orderedvecx>orderedvecx(i)))))
        gx(gcountx)=min(orderedvecx(find(orderedvecx>orderedvecx(i))));
        gcountx=gcountx+1;
    end
    if ~isempty(max(orderedvecx(find(orderedvecx<orderedvecx(i)))))
        gx(gcountx)=max(orderedvecx(find(orderedvecx<orderedvecx(i))));
    end
    gcountx=1;
    if ~isempty(min(orderedvecy(find(orderedvecy>orderedvecy(i)))))
        gy(gcounty)=min(orderedvecy(find(orderedvecy>orderedvecy(i))));
        gcounty=gcounty+1;
    end
    if ~isempty(max(orderedvecy(find(orderedvecy<orderedvecy(i)))))
        gy(gcounty)=max(orderedvecy(find(orderedvecy<orderedvecy(i))));
    end
    gcounty=1;
    gx;
    gy;
    for j=1:length(gx)
        for k=1:length(gy)
            tp3x=gx(j);
            tp3y=gy(k);
            
            
            tp1x=gx(j);
            tp1y=orderedvecy(i);
            tp2x=orderedvecx(i);
            tp2y=gy(k);
            if i==1
                prev=length(orderedvecx);
                post=2;
            elseif i==length(orderedvecx)
                prev=i-1;
                post=1;
            else
                prev=i-1;
                post=i+1;
            end
            if ~(((orderedvecx(prev)==tp1x)&(orderedvecy(prev)==tp1y))|((orderedvecx(post)==tp1x)&(orderedvecy(post)==tp1y)))
                if ~bettersandwich(orderedvecx(i),orderedvecy(i),tp1x,tp1y,orderedvecx,orderedvecy)
                    continue
                end
            end
            if ~(((orderedvecx(prev)==tp2x)&(orderedvecy(prev)==tp2y))|((orderedvecx(post)==tp2x)&(orderedvecy(post)==tp2y)))
                if ~bettersandwich(orderedvecx(i),orderedvecy(i),tp2x,tp2y,orderedvecx,orderedvecy)
                    continue
                end
            end
            
            ind1=find(orderedvecx==tp1x&orderedvecy==tp1y);
            if ind1==1
                prev=length(orderedvecx);
                post=2;
            elseif ind1==length(orderedvecx)
                prev=ind1-1;
                post=1;
            else
                prev=ind1-1;
                post=ind1+1;
            end
            if isempty(ind1)
                if ~bettersandwich(tp1x,tp1y,tp3x,tp3y,orderedvecx,orderedvecy)
                    continue
                end
            else
                if ~(((orderedvecx(prev)==tp3x)&(orderedvecy(prev)==tp3y))|((orderedvecx(post)==tp3x)&(orderedvecy(post)==tp3y)))
                    save bug.mat ;
                    if ~bettersandwich(tp1x,tp1y,tp3x,tp3y,orderedvecx,orderedvecy)
                        continue
                    end
                end
            end
            
            ind2=find(orderedvecx==tp2x&orderedvecy==tp2y);
            if ind2==1
                prev=length(orderedvecx);
                post=2;
            elseif ind2==length(orderedvecx)
                prev=ind2-1;
                post=1;
            else
                prev=ind2-1;
                post=ind2+1;
            end
            if isempty(ind2)
                if ~bettersandwich(tp2x,tp2y,tp3x,tp3y,orderedvecx,orderedvecy)
                    continue
                end
            else
                if ~(((orderedvecx(prev)==tp3x)&(orderedvecy(prev)==tp3y))|((orderedvecx(post)==tp3x)&(orderedvecy(post)==tp3y)))
                    if ~bettersandwich(tp2x,tp2y,tp3x,tp3y,orderedvecx,orderedvecy)
                        continue
                    end
                end
            end
            
            if(isempty(find(orderedvecx==tp3x&orderedvecy==tp3y)))
                innerpointsx(innerpcount)=tp3x;
                innerpointsy(innerpcount)=tp3y;
                innerpcount=innerpcount+1;
            end
            
            duplicate=0;
            for l=1:outputcount
                if (sort(outputx(l,1:4))==sort([orderedvecx(i),tp1x,tp3x,tp2x])&sort(outputy(l,1:4))==sort([orderedvecy(i),tp1y,tp3y,tp2y]))
                    duplicate=1;
                end
            end
            if ~duplicate
                if plots
                    figure(1);
                    subplot(2,2,4);
                    hold on;
                    fill([orderedvecx(i),tp1x,tp3x,tp2x],[orderedvecy(i),tp1y,tp3y,tp2y],'b')
                end
                B=B+polyarea([orderedvecx(i),tp1x,tp3x,tp2x],[orderedvecy(i),tp1y,tp3y,tp2y]);
                if plots
                    string=sprintf('Area = %f',B);
                    title(string);
                    axis equal;
                    figure(2);
                    movegui(2,'northwest');
                    fill([orderedvecx(i),tp1x,tp3x,tp2x],[orderedvecy(i),tp1y,tp3y,tp2y],'b')
                    hold on;
                    axis equal;
                end
                outputx(outputcount+1,1:4)=[orderedvecx(i),tp1x,tp3x,tp2x];
                outputy(outputcount+1,1:4)=[orderedvecy(i),tp1y,tp3y,tp2y];
                outputcount=outputcount+1;
            end
        end
    end
    gx=[];
    gy=[];
    
    
end

%need a function for this bottom part so it recurses
%function(newtp3points, sortedvectorx, sortedvectory, oldtp3points)
gcountx=1;
gcounty=1;
%error when innperpointsx don't exist, don't run this, error
for i=1:length(innerpointsx)
    if ~isempty(min(orderedvecx(find(orderedvecx>innerpointsx(i)))))
        gx(gcountx)=min(orderedvecx(find(orderedvecx>innerpointsx(i))));
        gcountx=gcountx+1;
    end
    if ~isempty(max(orderedvecx(find(orderedvecx<innerpointsx(i)))))
        gx(gcountx)=max(orderedvecx(find(orderedvecx<innerpointsx(i))));
    end
    gcountx=1;
    if ~isempty(min(orderedvecy(find(orderedvecy>innerpointsy(i)))))
        gy(gcounty)=min(orderedvecy(find(orderedvecy>innerpointsy(i))));
        gcounty=gcounty+1;
    end
    if ~isempty(max(orderedvecy(find(orderedvecy<innerpointsy(i)))))
        gy(gcounty)=max(orderedvecy(find(orderedvecy<innerpointsy(i))));
    end
    gcounty=1;
    gx;
    gy;
    for j=1:length(gx)
        for k=1:length(gy)
            tp3x=gx(j);
            tp3y=gy(k);
            
            
            tp1x=gx(j);
            tp1y=innerpointsy(i);
            tp2x=innerpointsx(i);
            tp2y=gy(k);
            
            
            if ~bettersandwich(innerpointsx(i),innerpointsy(i),tp1x,tp1y,orderedvecx,orderedvecy)
                continue
            end
            
            
            if ~bettersandwich(innerpointsx(i),innerpointsy(i),tp2x,tp2y,orderedvecx,orderedvecy)
                continue
            end
            
            
            ind1=find(orderedvecx==tp1x&orderedvecy==tp1y);
            if ind1==1
                prev=length(orderedvecx);
                post=2;
            elseif ind1==length(orderedvecx)
                prev=ind1-1;
                post=1;
            else
                prev=ind1-1;
                post=ind1+1;
            end
            if isempty(ind1)
                if ~bettersandwich(tp1x,tp1y,tp3x,tp3y,orderedvecx,orderedvecy)
                    continue
                end
            else
                if ~(((orderedvecx(prev)==tp3x)&(orderedvecy(prev)==tp3y))|((orderedvecx(post)==tp3x)&(orderedvecy(post)==tp3y)))
                    if ~bettersandwich(tp1x,tp1y,tp3x,tp3y,orderedvecx,orderedvecy)
                        continue
                    end
                end
            end
            
            ind2=find(orderedvecx==tp2x&orderedvecy==tp2y);
            if ind2==1
                prev=length(orderedvecx);
                post=2;
            elseif ind2==length(orderedvecx)
                prev=ind2-1;
                post=1;
            else
                prev=ind2-1;
                post=ind2+1;
            end
            if isempty(ind2)
                if ~bettersandwich(tp2x,tp2y,tp3x,tp3y,orderedvecx,orderedvecy)
                    continue
                end
            else
                if ~(((orderedvecx(prev)==tp3x)&(orderedvecy(prev)==tp3y))|((orderedvecx(post)==tp3x)&(orderedvecy(post)==tp3y)))
                    if ~bettersandwich(tp2x,tp2y,tp3x,tp3y,orderedvecx,orderedvecy)
                        continue
                    end
                end
            end
            
            duplicate=0;
            for l=1:outputcount
                if (sort(outputx(l,1:4))==sort([innerpointsx(i),tp1x,tp3x,tp2x])&sort(outputy(l,1:4))==sort([innerpointsy(i),tp1y,tp3y,tp2y]))
                    duplicate=1;
                end
            end
            if ~duplicate
                if plots
                    figure(1);
                    subplot(2,2,4);
                    hold on;
                    fill([innerpointsx(i),tp1x,tp3x,tp2x],[innerpointsy(i),tp1y,tp3y,tp2y],'b')
                    axis equal;
                end
                B=B+polyarea([innerpointsx(i),tp1x,tp3x,tp2x],[innerpointsy(i),tp1y,tp3y,tp2y]);
                if plots
                    string=sprintf('Area = %f',B);
                    title(string);
                    figure(2);
                    movegui(2,'northwest');
                    fill([innerpointsx(i),tp1x,tp3x,tp2x],[innerpointsy(i),tp1y,tp3y,tp2y],'b')
                    hold on;
                    axis equal
                end
                outputx(outputcount+1,1:4)=[innerpointsx(i),tp1x,tp3x,tp2x];
                outputy(outputcount+1,1:4)=[innerpointsy(i),tp1y,tp3y,tp2y];
                outputcount=outputcount+1;
            end
        end
    end
    gx=[];
    gy=[];
    
    
end
if A-B<.00000000001
    if plots
        figure(1);
        subplot(2,2,4);
        string=sprintf('Area = %f and Area Matches!',B);
        title(string)
    end
else
    if plots
        figure(1);
        subplot(2,2,4);
        string=sprintf('Area = %f and !!!!!ERROR IN AREA!!!!!',B);
        title(string)
    end
    %error('Area Mismatch');
end
if plots
    figure(2);
end
end
