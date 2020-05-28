function varargout = Gui(varargin)
% COBA2 MATLAB code for coba2.fig
%      COBA2, by itself, creates a new COBA2 or raises the existing
%      singleton*.
%
%      H = COBA2 returns the handle to a new COBA2 or the handle to
%      the existing singleton*.
%
%      COBA2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COBA2.M with the given input arguments.
%
%      COBA2('Property','Value',...) creates a new COBA2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before coba2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to coba2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help coba2

% Last Modified by GUIDE v2.5 25-May-2020 14:39:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @coba2_OpeningFcn, ...
                   'gui_OutputFcn',  @coba2_OutputFcn, ...
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


% --- Executes just before coba2 is made visible.
function coba2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to coba2 (see VARARGIN)

% Choose default command line output for coba2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes coba2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = coba2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%% menngungah gambar dari filelocal
open=guidata(gcbo);
[fname, path]=uigetfile({'*.png;*.jpg'},'buka sebuah gambar untuk diklasifikasi');
fname=strcat(path, fname);
im=imread(fname);
set(open.figure1,'CurrentAxes',open.axes1);
set(imagesc(im));colormap('gray');
set(open.axes1,'Userdata',im);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
%% mengambil gambar dari axes1
open=guidata(gcbo);
im=get(open.axes1,'Userdata');
im=im2bw(im);
set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(im));colormap('gray');

%% Find the class the test image belongs
Ftest=FeatureStatistical(im);
%% membandingkan  dengan fitur training gambar dalam database
load db.mat
Ftrain=db(:,1:2);
Ctrain=db(:,3);
for (i=1:size(Ftrain,1));
    dist(i,:)=sum(abs(Ftrain(i,:)-Ftest));
end
m=find(dist==min(dist),1);
det_class=Ctrain(m);
a=num2str(det_class);
%% menampilkan hasil 
set(handles.text2,'String','Merupakan citra class'); 
set(handles.text3,'String',a);




% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
