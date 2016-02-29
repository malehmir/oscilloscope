function [X,Y]=OSC(obj1)
% READ WRITE and SAVE Oscilloscope signal directly from MATLAB
% The MIT License (MIT)
% Copyright (c) 2016 Reza Malehmir
% 
% Permission is hereby granted, free of charge, to any person obtaining 
% a copy of this software and associated documentation files (the "Software"),
% to deal in the Software without restriction, including without limitation the
% rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is furnished to do 
% so, subject to the following conditions:
%  
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
% INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
% PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
% FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
% ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
% Last Modified by GUIDE v2.5 20-Jan-2016 14:40:36
%
% For more information contact the author: malehmir@ualberta.ca
%
 load TEKTRONIX.mat
 disconnect(obj1)
 connect(obj1) 
groupObj = get(obj1, 'Waveform');
[Y,X] = invoke(groupObj, 'readwaveform', 'channel1');
 plot(X,mean(Y),'k');
 xlabel('Time (sec)');
 ylabel('Voltage (V)');