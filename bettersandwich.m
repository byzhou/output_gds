function connect=bettersandwich(x1,y1,x2,y2,zx,zy)

passcount=0;
fail=1;

%parallel to y axis
if x1==x2
    while fail==1
        r = (y1-y2).*rand(1,1) + y2;
        if isempty(find(zy==r))
            for i=1:length(zy)
                if (zx(i)>x1)
                    if i==length(zy)
                        if (((r>zy(i))&&(r<zy(1)))||((r<zy(i))&&(r>zy(1))))
                            passcount=passcount+1;
                        end
                    else
                        if (((r>zy(i))&&(r<zy(i+1)))||((r<zy(i))&&(r>zy(i+1))))
                            passcount=passcount+1;
                        end
                    end  
                end
            end
            fail=0;
        else
        end
    end
        
end

%parallel to x axis
if y1==y2
    while fail==1
        r = (x1-x2).*rand(1,1) + x2;
        if isempty(find(zx==r))
            for i=1:length(zx)
                if (zy(i)>y1)
                    if i==length(zx)
                        if (((r>zx(i))&&(r<zx(1)))||((r<zx(i))&&(r>zx(1))))
                            passcount=passcount+1;
                        end
                    else
                        if (((r>zx(i))&&(r<zx(i+1)))||((r<zx(i))&&(r>zx(i+1))))
                            passcount=passcount+1;
                        end
                    end
                end
            end
            fail=0;
        else
        end
    end
        
end

if mod(passcount,2)==1
    connect=1;
else
    connect=0;
end

end