clear all;
clc;
text = fileread('C:\Users\Training\Desktop\99003563\MBD Training\Motor Drivers - STMicroelectronics.html');
Lines = strsplit(text,newline);
k=1;
for i=1:length(Lines)
    if contains(Lines{i},"<a")
        newStr = extractBetween(Lines{i},"<a",">");
        for j=1:length(newStr)
            ValueStorage{k}=newStr{j};
            k=k+1;
        end
    end
end     
ValueStorage=vertcat("HTML Tag Value",ValueStorage');
ValueStorage_XLS= cellstr(ValueStorage);
xlswrite("TagA.xlsx",ValueStorage_XLS);
