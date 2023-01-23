function varargout = ADM1Output(varargin)
% ADM1OUTPUT M-file for ADM1Output.fig
%      ADM1OUTPUT, by itself, creates a new ADM1OUTPUT or raises the existing
%      singleton*.
%
%      H = ADM1OUTPUT returns the handle to a new ADM1OUTPUT or the handle to
%      the existing singleton*.
%
%      ADM1OUTPUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADM1OUTPUT.M with the given input arguments.
%
%      ADM1OUTPUT('Property','Value',...) creates a new ADM1OUTPUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ADM1Output_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ADM1Output_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ADM1Output

% Last Modified by GUIDE v2.5 17-Apr-2004 00:03:47
global out time
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ADM1Output_OpeningFcn, ...
                   'gui_OutputFcn',  @ADM1Output_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ADM1Output is made visible.
function ADM1Output_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ADM1Output (see VARARGIN)

% Choose default command line output for ADM1Output
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ADM1Output wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ADM1Output_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function REACTOR_STATES_CreateFcn(hObject, eventdata, handles)
% hObject    handle to REACTOR_STATES (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in REACTOR_STATES.
function REACTOR_STATES_Callback(hObject, eventdata, handles)
% hObject    handle to REACTOR_STATES (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns REACTOR_STATES contents as cell array
%        contents{get(hObject,'Value')} returns selected item from REACTOR_STATES


% --- Executes on button press in SCOPE.
function SCOPE_Callback(hObject, eventdata, handles)
% hObject    handle to SCOPE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plotstates = get(handles.REACTOR_STATES,'Value');
str_plotstates = strcat('[',num2str(plotstates),']');
set_param('ADM1/Selector','Elements',str_plotstates)


% --- Executes on button press in PLOT.
function PLOT_Callback(hObject, eventdata, handles)
% hObject    handle to PLOT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plotstates = get(handles.REACTOR_STATES,'Value');
list_entries = get(handles.REACTOR_STATES,'String');
len=length(plotstates);
time=evalin('base','time');
out=evalin('base','out');

if length(time) ~=0
    % Get data to plot
    legendStr = cell(length(plotstates),1);
    plotColor = {'b','g','r','c','m','y','k'};
    for ctVal = 1:length(plotstates);
	    PlotData{(ctVal*3)-2} = time;
	    PlotData{(ctVal*3)-1} = out(:,plotstates(ctVal));	
	    numColor = ctVal - 7*( floor((ctVal-1)/7) );
	    PlotData{ctVal*3} = plotColor{numColor};
	    legendStr(ctVal) = list_entries(plotstates(ctVal));
    end

    % If necessary, create the plot figure and store in handles structure
    if ~isfield(handles,'PlotFigure') | ~ishandle(handles.PlotFigure),
    	handles.PlotFigure = figure('Name','ADM1 OutPut','Visible','off',...
		    'NumberTitle','off','HandleVisibility','off','IntegerHandle','off');
    	handles.PlotAxes = axes('Parent',handles.PlotFigure);
    	guidata(hObject,handles)
    end 

    % Plot data
    pHandles = plot(PlotData{:},'Parent',handles.PlotAxes);

    % Add a legend, and bring figure to the front
    legend(pHandles(1:1:end),legendStr{:})
    % Make the figure visible and bring it forward
    figure(handles.PlotFigure)
end



