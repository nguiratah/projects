%Written by Ing. Gentian Zavalani at Polytechnic University of Tirana.
%% zavalanigentian@hotmail.com%%

function varargout = odesolver(varargin)
% ODESOLVER MATLAB code for odesolver.fig
%      ODESOLVER, by itself, creates a new ODESOLVER or raises the existing
%      singleton*.
%
%      H = ODESOLVER returns the handle to a new ODESOLVER or the handle to
%      the existing singleton*.
%
%      ODESOLVER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ODESOLVER.M with the given input arguments.
%
%      ODESOLVER('Property','Value',...) creates a new ODESOLVER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before odesolver_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to odesolver_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help odesolver

% Last Modified by GUIDE v2.5 18-Jan-2014 00:01:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @odesolver_OpeningFcn, ...
                   'gui_OutputFcn',  @odesolver_OutputFcn, ...
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


% --- Executes just before odesolver is made visible.
function odesolver_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to odesolver (see VARARGIN)

% Choose default command line output for odesolver
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes odesolver wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = odesolver_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.checkbox1,'Value')==1
    set(handles.checkbox2,'Value',0);
    set(handles.checkbox3,'Value',0);
    set(handles.checkbox4,'Value',0);
    set(handles.checkbox6,'Value',0);
    set(handles.checkbox7,'Value',0);
    set(handles.checkbox8,'Value',0);
end
% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
if get(handles.checkbox2,'Value')==1
    set(handles.checkbox1,'Value',0);
    set(handles.checkbox3,'Value',0);
    set(handles.checkbox4,'Value',0);
    set(handles.checkbox6,'Value',0);
    set(handles.checkbox7,'Value',0);
    set(handles.checkbox8,'Value',0);
end

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
if get(handles.checkbox3,'Value')==1
    set(handles.checkbox2,'Value',0);
    set(handles.checkbox1,'Value',0);
    set(handles.checkbox4,'Value',0);
    set(handles.checkbox6,'Value',0);
    set(handles.checkbox7,'Value',0);
    set(handles.checkbox8,'Value',0);
end
% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4

if get(handles.checkbox4,'Value')==1
    set(handles.checkbox2,'Value',0);
    set(handles.checkbox3,'Value',0);
    set(handles.checkbox1,'Value',0);
    set(handles.checkbox6,'Value',0);
    set(handles.checkbox7,'Value',0);
    set(handles.checkbox8,'Value',0);
end
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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dyexpression
dyexpression=get(handles.edit1,'String');
t0=str2num(get(handles.edit2,'String'));
tf=str2num(get(handles.edit3,'String'));
ICvalue=str2num(get(handles.edit4,'String'));
ode45method = get(handles.checkbox1,'Value');
ode15smethod = get(handles.checkbox2,'Value');
ode23smethod = get(handles.checkbox3,'Value');
ode113method = get(handles.checkbox4,'Value');
ode15imethod = get(handles.checkbox6,'Value');
ode23tmethod = get(handles.checkbox7,'Value');
ode23method = get(handles.checkbox8,'Value');

switch get(handles.popupmenu1,'Value')   
    case 1
        linecolor='b';
        set(handles.text5,'ForegroundColor','b');
    case 2
        linecolor='g';
        set(handles.text5,'ForegroundColor','g');
    case 3
        linecolor='r';
        set(handles.text5,'ForegroundColor','r');
    case 4
        linecolor='m';
        set(handles.text5,'ForegroundColor','m');
    case 5
        linecolor='k';
        set(handles.text5,'ForegroundColor','k');
    otherwise
end

if ode45method==0 & ode15smethod==0 & ode23smethod==0 & ode113method==0 ode15imethod==0 & ode23tmethod==0 &ode23method==0 %no method selected
    ode45method=1;
    set(handles.checkbox1,'Value',1)
end

if ode45method==1 
    [t,y] = ode45(@yprime,[t0 tf],ICvalue);
elseif ode15smethod==1 
    [t,y] = ode15s(@yprime,[t0 tf],ICvalue);
    elseif ode23smethod==1 
    [t,y] = ode23s(@yprime,[t0 tf],ICvalue);
elseif  ode113method==1 
    [t,y] = ode113(@yprime,[t0 tf],ICvalue);
     elseif ode15imethod==1 
    [t,y] = ode15i(@yprime,[t0 tf],ICvalue);
     elseif ode23tmethod==1 
    [t,y] = ode23t(@yprime,[t0 tf],ICvalue);
else ode23method==1 
    [t,y] = ode23(@yprime,[t0 tf],ICvalue);
    
    if linecolor=='g' 
    linecolor = 'b';
    set(handles.popupmenu1,'Value',3);
    set(handles.text5,'ForegroundColor','b');
    end
end
if get(handles.checkbox5,'Value')==0
    hold on
elseif get(handles.checkbox5,'Value')==1
    hold off
end
axes(handles.axes1)
plot(t,y(:,1),linecolor,'LineWidth',1) 
xlabel('t')
ylabel('y')

guidata(hObject, handles);
function dy=yprime(t,y)     %User defined 1st-oder ODE.
global dyexpression
dy=eval(dyexpression);   %eval is needed to calcualte string expression.


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6
if get(handles.checkbox6,'Value')==1
    set(handles.checkbox2,'Value',0);
    set(handles.checkbox3,'Value',0);
    set(handles.checkbox4,'Value',0);
    set(handles.checkbox1,'Value',0);
    set(handles.checkbox7,'Value',0);
    set(handles.checkbox8,'Value',0);
end

% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7
if get(handles.checkbox7,'Value')==1
    set(handles.checkbox2,'Value',0);
    set(handles.checkbox3,'Value',0);
    set(handles.checkbox4,'Value',0);
    set(handles.checkbox6,'Value',0);
    set(handles.checkbox1,'Value',0);
    set(handles.checkbox8,'Value',0);
end

% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.checkbox8,'Value')==1
    set(handles.checkbox2,'Value',0);
    set(handles.checkbox3,'Value',0);
    set(handles.checkbox4,'Value',0);
    set(handles.checkbox6,'Value',0);
    set(handles.checkbox7,'Value',0);
    set(handles.checkbox1,'Value',0);
end
% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
imshow('upt.gif');
% Hint: place code in OpeningFcn to populate axes3
