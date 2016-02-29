function varargout = Scope(varargin)
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
%%
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Scope_OpeningFcn, ...
                   'gui_OutputFcn',  @Scope_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Scope is made visible.
function Scope_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Scope (see VARARGIN)

% Choose default command line output for Scope
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Scope wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Scope_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in plot2axis.
function [t,Y,Ystd]=plot2axis_Callback(hObject, eventdata, handles)
% hObject    handle to plot2axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%##########
%%  LOADING THE OSCILLOSCOPE DRIVER
load TEKTRONIX.mat
disconnect(obj1)
connect(obj1) 
% Read average parameters Nmax from the GUI
Nmax=5;
Nmax=str2num(get(handles.NMAX,'String'));
set(handles.status,'String','reading...')
set(handles.status,'BackgroundColor',[1 0 0])
pause(0.001)
[t,y(:,1)]=OSC(obj1);
for i=2:Nmax
    [~,y(:,i)]=OSC(obj1);
    Y=mean(y');
    Ystd=std(y');
    plot(t,Y.*ones(size(t)),'k',t,(Y+Ystd).*ones(size(t)),'.-r',t,(Y-Ystd).*ones(size(t)),'.-r');
    msg=['reading...',num2str(i),'out of ',num2str(Nmax)];
    set(handles.status,'String',msg);
pause(0.001)
end
assignin('base', 'Y', Y);
assignin('base', 'Ystd', Ystd);
assignin('base', 't', t);
fprintf('DONE!\n')
set(handles.status,'String','READY!')
set(handles.status,'BackgroundColor',[0 1 0])
% --- Executes on button press in save2file.
function save2file_Callback(hObject, eventdata, handles,t,Y,Ystd)
% hObject    handle to save2file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Y=evalin('base','Y');
Ystd=evalin('base','Ystd');
t=evalin('base','t');
filename=get(handles.filename,'String');
save(filename,'Y','Ystd','t')
set(handles.status,'String','saved!')

function filename_Callback(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename as text
%        str2double(get(hObject,'String')) returns contents of filename as a double


% --- Executes during object creation, after setting all properties.
function filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NMAX_Callback(hObject, eventdata, handles)
% hObject    handle to NMAX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NMAX as text
%        str2double(get(hObject,'String')) returns contents of NMAX as a double


% --- Executes during object creation, after setting all properties.
function NMAX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NMAX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
