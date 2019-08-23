function varargout = PjImage(varargin)
% PJIMAGE MATLAB code for PjImage.fig
%      PJIMAGE, by itself, creates a new PJIMAGE or raises the existing
%      singleton*.
%
%      H = PJIMAGE returns the handle to a new PJIMAGE or the handle to
%      the existing singleton*.
%
%      PJIMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PJIMAGE.M with the given input arguments.
%
%      PJIMAGE('Property','Value',...) creates a new PJIMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PjImage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PjImage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PjImage

% Last Modified by GUIDE v2.5 21-Aug-2019 09:54:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PjImage_OpeningFcn, ...
                   'gui_OutputFcn',  @PjImage_OutputFcn, ...
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


% --- Executes just before PjImage is made visible.
function PjImage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PjImage (see VARARGIN)

% Choose default command line output for PjImage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PjImage wait for user response (see UIRESUME)
% uiwait(handles.figure_PjImage);

% 传递图像img_src
setappdata(handles.figure_PjImage,'img_src',0)
% 图像是否保存
setappdata(handles.figure_PjImage,'bSave',false)
% 图像是否已经处理
setappdata(handles.figure_PjImage,'bChanged',false); 
% 是否是第一次保存
setappdata(handles.figure_PjImage,'fstSave',true);
% 定义保存的通道
setappdata(handles.figure_PjImage,'fstPath',0);

% 暂时关闭菜单栏
set(handles.m_image,'Enable','off');
set(handles.tbl_save, 'Enable', 'off');
set(handles.m_file_save, 'Enable', 'off');




% --- Outputs from this function are returned to the command line.
function varargout = PjImage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function m_file_Callback(hObject, eventdata, handles)
% hObject    handle to m_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_file_open_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
{'*.jpg;*.png',...
 'Image Files (*.jpg, *.png)';...
   '*.jpg',  'Image Files (*.jpg)'; ...
   '*.png','Image Files (*.png)'; ...  
   '*.*',  'All Files (*.*)'}, ...
   'Pick an Image');
if isequal(filename,0) || isequal(pathname,0)
    return;
end
axes(handles.axes1);
fpath = [pathname filename];
img_src = imread(fpath);
imshow(img_src);
setappdata(handles.figure_PjImage,'img_src',img_src)

% 打开菜单栏
set(handles.m_image,'Enable','on')
set(handles.tbl_save, 'Enable', 'on');
set(handles.m_file_save, 'Enable', 'on');

% --------------------------------------------------------------------
function m_file_save_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uiputfile(...
    {'*.jpg','JPG Files';...
    '*.png','PNG Files (*.png)'},...
    'Pick an Image');
if isequal(filename,0) || isequal(pathname,0)
    return;
else
    fpath = fullfile(pathname, filename);
end
img_src = getappdata(handles.figure_PjImage,'img_src');
imwrite(img_src,fpath);
close(img_src,fpath);
% --------------------------------------------------------------------
function m_file_exit_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bChanged = getappdata(handles.figure_PjImage,'bChanged');
bSave = getappdata(handles.figure_PjImage,'bSave');
if bChanged==true && bSave==false
    btnName = questdlg('图片已经更改，需要保存吗？',...
    '提示',...
    '保存','不保存','保存');
    switch btnName
        case '保存'
            feval(@axes_dst_menu_save_Callback,handles.axes_dst_menu_save,eventdata,handles);
        case '不保存'
    end
end

h = findobj('Tag', 'figure_im2bw');
if ~isempty(h)
    close(h);
end
close(findobj('Tab', 'figure_PjImage'));
    
% --------------------------------------------------------------------
function m_image_Callback(hObject, eventdata, handles)
% hObject    handle to m_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_image_2bw_Callback(hObject, eventdata, handles)
% hObject    handle to m_image_2bw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = im2bw_args;
% 确认图像经过变换
setappdata(handles.figure_PjImage,'bChanged',true); 


% --------------------------------------------------------------------
function axes_dst_menu_save_Callback(hObject, eventdata, handles)
% hObject    handle to axes_dst_menu_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uiputfile({'*.jpg','JPG files','Pick an image'});
if isequal(filename,0) || isequal(pathname,0)
    return;
else
    fpath = fullfile(pathname,filename);
end
img_dst = getimage(handles.axes_dst);
imwrite(img_dst,fpath);
setappdata(handles.figure_figure_PjImage,'bSave',true);
% --------------------------------------------------------------------
function axes_dst_menu_Callback(hObject, eventdata, handles)
% hObject    handle to axes_dst_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function tbl_open_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to tbl_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
feval(@m_file_open_Callback,handles.m_file_open,eventdata,handles);


% --------------------------------------------------------------------
function tbl_save_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to tbl_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fstSave = getappdata(handles.figure_PjImage,'fstSave');
if (fstSave == true)
    [filename, pathname] = uiputfile(...
        {'*.jpg','JPG Files';...
        '*.png','PNG Files (*.png)'},...
        'Pick an Image');
    if isequal(filename,0) || isequal(pathname,0)
        return;
    else
        fpath = fullfile(pathname, filename);
    end
    img_dst = getimage(handles.axes_dst);
    imwrite(img_dst,fpath);
    setappdata(handles.figure_PjImage, 'fstPath', fpath);
    setappdata(handles.figure_PjImage, 'bSave', true);
    srtappdata(handles.figure_PjImage, 'fstSave', false);
else
    img_dst = getimage(handles.axes_dst);
    fpath = getappdata(handles.figure_PjImage, 'fstPath');
    imwrite(img_dst, fpath);
end
    
    