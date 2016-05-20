{*******************************************************}
{                                                       }
{       CodeGear Delphi Visual Component Library        }
{                                                       }
{           Copyright (c) 1995-2007 CodeGear            }
{                                                       }
{*******************************************************}

unit Consts;

interface

resourcestring
  SOpenFileTitle = 'Abrir';
  SCantWriteResourceStreamError = 'No es posible escribir en un recurso de s�lo lectura';
  SDuplicateReference = 'WriteObject ha sido llamado dos veces desde la misma instancia';
  SClassMismatch = 'Recurso %s es de una clase incorrecta';
  SInvalidTabIndex = '�ndice Tab incorrecto';
  SInvalidTabPosition = 'Posici�n del Tab incompatible con el actual estilo de Tabs';
  SInvalidTabStyle = 'Tab style incompatible with current tab position';
  SInvalidBitmap = 'Imagen Bitmap no tiene un formato incorrecto';
  SInvalidIcon = 'La imagen del icono no es v�lida';
  SInvalidMetafile = 'Metafile no es v�lido';
  SInvalidPixelFormat = 'Formato inv�lido de pixel';
  SInvalidImage = 'Imagen inv�lida';
  SBitmapEmpty = 'El Bitmap est� vacio';
  SScanLine = '�ndice de Scan line est� fuera de rango';
  SChangeIconSize = 'No se puede cambiar el tama�o del icono';
  SOleGraphic = 'Operaci�n inv�lida en TOleGraphic';
  SUnknownExtension = 'Extensi�n de archivo de imagen desconocido (.%s)';
  SUnknownClipboardFormat = 'Formato de portapapeles no soportado';
  SOutOfResources = 'Recursos del sistema agotados';
  SNoCanvasHandle = 'Canvas no permite dibujar';
  SInvalidImageSize = 'Tama�o de imagen inv�lido';
  STooManyImages = 'Demasiadas im�genes';
  SDimsDoNotMatch = 'Image dimensions do not match image list dimensions';
  SInvalidImageList = 'ImageList inv�lido';
  SReplaceImage = 'No se puede reemplazar imagen';
  SImageIndexError = '�ndice de ImageList inv�lido';
  SImageReadFail = 'Fallo al leer datos de ImageList desde stream';
  SImageWriteFail = 'Fallo al escribir datos de ImageList desde stream';
  SWindowDCError = 'Error creando ventana (window) del (device context)';
  SClientNotSet = 'Cliente de TDrag no inicializado';
  SWindowClass = 'Error creando una ventana de esa clase';
  SWindowCreate = 'Error creando ventana';
  SCannotFocus = 'No es posible asignar el foco de una ventana desactiva o invisible';
  SParentRequired = 'Control ''%s'' no tiene ventana padre';
  SParentGivenNotAParent = 'Parent especificado no es un parent de ''%s''';
  SMDIChildNotVisible = 'No es posible ocultar una ventana MDI hija';
  SVisibleChanged = 'No es posible cambiar Visible in OnShow or OnHide';
//
   SCannotShowModal = 'No es posible hacer una ventana visible como modal';
  SScrollBarRange = 'Propiedad del Scrollbar fuera de rango';
  SPropertyOutOfRange = 'Propiedad %s fuera de rango';
  SMenuIndexError = 'Men� �ndice fuera de rango';
  SMenuReinserted = 'Men� insertado dos veces';
  SMenuNotFound = 'El Sub-men� no est� en el men�';
  SNoTimers = 'No hay suficientes timers disponibles';
  SNotPrinting = 'La impresora no est� imprimiendo actualmente';
  SPrinting = 'Impresi�n en marcha';
  SPrinterIndexError = '�ndice de impresora fuera de rango';
  SInvalidPrinter = 'La impresora seleccionada no es v�lida';
  SDeviceOnPort = '%s on %s';
  SGroupIndexTooLow = 'GroupIndex no puede ser menor que el �tem de men� anterior GroupIndex';
  STwoMDIForms = 'No se puede abrir m�s de un formulario MDI por aplicaci�n';
  SNoMDIForm = 'No se puede crear Form. No hay formularios MDI que est�n activos actualmente';
  SImageCanvasNeedsBitmap = 'S�lo se puede modificar fichero de imagen si es de tipobitmap';
  SControlParentSetToSelf = 'El control no puede tenerse a s� mismo como parent';
  SOKButton = 'Aceptar';
  SCancelButton = 'Cancelar';
  SYesButton = '&S�';
  SNoButton = '&No';
//
  SHelpButton = '&Ayuda';
  SCloseButton = '&Cerrar';
  SIgnoreButton = '&Ignorar';
  SRetryButton = '&Reintentar';
  SAbortButton = 'Cancelar';
  SAllButton = '&Todo';

  SCannotDragForm = 'No es posible arrastrar el formulario';
  SPutObjectError = 'PutObject a un �tem no definido';
  SCardDLLNotLoaded = 'No se puede cargar CARDS.DLL';
  SDuplicateCardId = 'Se ha detectado un CardId duplicado';

  SDdeErr = 'Error devuelto por DDE  ($0%x)';
  SDdeConvErr = 'DDE Error - Conversaci�n no establecida ($0%x)';
  SDdeMemErr = 'Un error ocurri� y DDE fall� (ran out) en memoria ($0%x)';
  SDdeNoConnect = 'No es posible conectar (connect) una conversaci�n DDE';

  SFB = 'FB';
  SFG = 'FG';
  SBG = 'BG';
  SOldTShape = 'No se pueden cargar versiones antiguas de TShape';
  SVMetafiles = 'Metafiles';
  SVEnhMetafiles = 'Enhanced Metafiles (mejorados)';
  SVIcons = 'Iconos';
  SVBitmaps = 'Bitmaps';
  SGridTooLarge = 'Grid demasiado grande para la operaci�n';
  STooManyDeleted = 'Demasiadas filas o columnas borradas';
  SIndexOutOfRange = '�ndice de la rejilla fuera de rango';
  SFixedColTooBig = 'La propiedad count(contador) de la Columna fija count debe ser menor que el count de la columna';
  SFixedRowTooBig = 'Fixed row count must be less than row count';
  SInvalidStringGridOp = 'No se puede insertar o borrar filas del Grid(rejilla)';
  SInvalidEnumValue = 'Valor Enum no v�lido';
  SInvalidNumber = 'Valor num�rico inv�lido';
  SOutlineIndexError = '�ndice Outline index no encontrado';
  SOutlineExpandError = 'Parent(padre) debe estar expandido';
  SInvalidCurrentItem = 'Valor no v�lido para el �tem actual';
  SMaskErr = 'Valor de entrada inv�lido';
  SMaskEditErr = 'Valor introducido no v�lido.  Use la tecla escape para deshacer los cambios';
  SOutlineError = '�ndice inv�lido outline index';
  SOutlineBadLevel = 'Nivel de asignaci�n incorrecto';
  SOutlineSelection = 'Selecci�n inv�lida';
  SOutlineFileLoad = 'Error al cargar fichero';
  SOutlineLongLine = 'L�nea demasiado larga';
  SOutlineMaxLevels = 'Se ha excedido la profundidad m�xima de outline';

  SMsgDlgWarning = 'Aviso';
  SMsgDlgError = 'Error';
  SMsgDlgInformation = 'Informaci�n';
  SMsgDlgConfirm = 'Confirmaci�n';
  SMsgDlgYes = '&S�';
  SMsgDlgNo = '&No';
  SMsgDlgOK = 'Aceptar';
  SMsgDlgCancel = 'Cancelar';
  SMsgDlgHelp = '&Ayuda';
  SMsgDlgHelpNone = 'No hay ayuda disponible';
  SMsgDlgHelpHelp = 'Ayuda';
  SMsgDlgAbort = '&Cancelar';
  SMsgDlgRetry = '&Reintentar';
  SMsgDlgIgnore = '&Ignorar';
  SMsgDlgAll = '&Todo';
  SMsgDlgNoToAll = 'N&o a todo';
  SMsgDlgYesToAll = '&S� a todo';

  SmkcBkSp = 'BkSp';
  SmkcTab = 'Tabulador';
  SmkcEsc = 'Escape';
  SmkcEnter = 'Intro';
  SmkcSpace = 'Barra espaciadora';
  SmkcPgUp = 'AvPag';
  SmkcPgDn = 'RePag';
  SmkcEnd = 'Fin';
  SmkcHome = 'Inicio';
  SmkcLeft = 'Izquierda';
  SmkcUp = 'Arriba';
  SmkcRight = 'Derecha';
  SmkcDown = 'Abajo';
  SmkcIns = 'Insertar';
  SmkcDel = 'Del';
  SmkcShift = 'Shift+';
  SmkcCtrl = 'Ctrl+';
  SmkcAlt = 'Alt+';

  srUnknown = '(Desconocido)';
  srNone = '(Ninguno)';
  SOutOfRange = 'El valor debe estar entre %d y %d';

  SDateEncodeError = 'Argumento inv�lido al codificar fecha';
  SDefaultFilter = 'Todos los archivos (*.*)|*.*';
  sAllFilter = 'Todos';
  SNoVolumeLabel = ': [ - no hay etiqueta de volumen - ]';
  SInsertLineError = 'No es posible insertar una l�nea';


  SConfirmCreateDir = 'La carpera especificada no existe. �Desea crearla?';
  SSelectDirCap = 'Seleccione una carpeta';
  SDirNameCap = '&Nombre de la carpeta:';
  SDrivesCap = '&Unidades:';
  SDirsCap = '&Directorios:';
  SFilesCap = '&Ficheros: (*.*)';
  SNetworkCap = 'R&ed...';

  SColorPrefix = 'Color';               //!! obsolete - delete in 5.0
  SColorTags = 'ABCDEFGHIJKLMNOP';      //!! obsolete - delete in 5.0

  SInvalidClipFmt = 'Formato no v�lido de portapapeles';
  SIconToClipboard = 'El portapapeles no soporta iconos';
  SCannotOpenClipboard = 'No se puede abrir portapapeles';

  SDefault = 'Por defecto';

  SInvalidMemoSize = 'El texto excede la capacidad del campo memo';
  SCustomColors = 'Colores personalizados';
  SInvalidPrinterOp = 'La operac��n no esta soportada en la impresora seleccionada';
  SNoDefaultPrinter = 'No hay una impresora establecida como predeterminada';

  SIniFileWriteError = 'No es posible escribir en %s';

  SBitsIndexError = '�ndice de bits fuera de rango';

  SUntitled = '(Sin t�tulo)';

  SInvalidRegType = 'Tipo de dato inv�lido para ''%s''';

  SUnknownConversion = 'No conocida la extensi�n para RichEdit  (.%s)';
  SDuplicateMenus = 'Men� ''%s'' est� siendo usado por otro formulario';

  SPictureLabel = 'Picture:';
  SPictureDesc = ' (%dx%d)';
  SPreviewLabel = 'Presentaci�n';

  SCannotOpenAVI = 'No se puede abrir AVI';

  SNotOpenErr = 'No hay una unidad MCI abierta';
  SMPOpenFilter = 'Todos los ficheros (*.*)|*.*|ficheros wave (*.wav)|*.wav|Ficheros Midi (*.mid)|*.mid|Video para Windows (*.avi)|*.avi';
  SMCINil = '';
  SMCIAVIVideo = 'AVIVideo';
  SMCICDAudio = 'CDAudio';
  SMCIDAT = 'DAT';
  SMCIDigitalVideo = 'DigitalVideo';
  SMCIMMMovie = 'MMMovie';
  SMCIOther = 'Other';
  SMCIOverlay = 'Overlay';
  SMCIScanner = 'Scanner';
  SMCISequencer = 'Sequencer';
  SMCIVCR = 'VCR';
  SMCIVideodisc = 'Videodisc';
  SMCIWaveAudio = 'WaveAudio';
  SMCIUnknownError = 'Error desconocido en componente MCI';

  SBoldItalicFont = 'It�lica negrita';
  SBoldFont = 'Negrita';
  SItalicFont = 'It�lica';
  SRegularFont = 'Normal';

  SPropertiesVerb = 'Propiedades';

  SServiceFailed = 'Servicio fall� en %s: %s';
  SExecute = 'ejecutar';
  SStart = 'empezar';
  SStop = 'parar';
  SPause = 'pausa';
  SContinue = 'continuar';
  SInterrogate = 'preguntar';
  SShutdown = 'apagar';
  SCustomError = 'Servicio fall� en mensaje personalizado(%d): %s';
  SServiceInstallOK = 'Servicio instalado satisfactoriamente';
  SServiceInstallFailed = 'Servicio "%s" fall� al instalarse. Error: "%s"';
  SServiceUninstallOK = 'Servicio desinstalado satisfactoriamente';
  SServiceUninstallFailed = 'Servicio "%s" fall� al desinstalarse. Error: "%s"';

  SInvalidActionRegistration = 'Acci�n no v�lida registrando';
  SInvalidActionUnregistration = 'Acci�n no v�lida desregistrando';
  SInvalidActionEnumeration = 'Acci�n no v�lida enumerando';
  SInvalidActionCreation = 'Acci�n no v�lida creando';

  SDockedCtlNeedsName = 'Docked control debe tener un nomre';
  SDockTreeRemoveError = 'Error borrando control del �rbol dock';
  SDockZoneNotFound = ' - zona Dock no encontrada';
  SDockZoneHasNoCtl = ' - zona Dock no tiene control';
  // no al encontre referenciada en el otro
  SDockZoneVersionConflict = 'Error loading dock zone from the stream. ' +
    'Expecting version %d, but found %d.';

  SAllCommands = 'Todos los Comandos';

  SDuplicateItem = 'La lista no permite duplicados ($0%x)';

  STextNotFound = 'Texto no encontrada: "%s"';
  SBrowserExecError = 'Navegador por defecto no especificado';

  SColorBoxCustomCaption = 'Usuario...';


  SMultiSelectRequired = 'El modo Multiselect debe estar presente para esta caracter�stica';

  SKeyCaption = 'Clave';
  SValueCaption = 'Valor';
  SKeyConflict = 'Una clave con el mismo nombre "%s" ya existe';
  SKeyNotFound = 'Clave "%s" no encontrada';
  SNoColumnMoving = 'goColMoving no es una opci�n soportada';
  SNoEqualsInKey = 'La Clave puede que no contenga el signo ("=")';

  SSendError = 'Error enviando e-mail';
  SAssignSubItemError = 'No se puede asignar este �tem a un sub-�tem actionbar cuando uno de sus parents(padres) ya est� asignado a un ActionBar';
  SDeleteItemWithSubItems = '�tem %s tiene sub�tems, �borrar de todas maneras?';
  SDeleteNotAllowed = 'No tiene permiso para borrar este �tem';
  SMoveNotAllowed = '�tem %s no se puede mover';    
  SMoreButtons = 'M�s Botones';
  SErrorDownloadingURL = 'Error descargando URL: %s';
  SUrlMonDllMissing = 'No se puede cargar %s';
  SAllActions = '(Todas las acciones)';
  SNoCategory = '(Sin Categor�a)';
  SExpand = 'Expand';
  SErrorSettingPath = 'Error estableciendo ruta: "%s"';
  SLBPutError = 'Intento de meter �tems en un listbox(caja de lista) virtual';
  SErrorLoadingFile = 'Error cargando datos de establecimiento previamente guardados en: %s'#13'�Le gustar�a borrarlo?';
  SResetUsageData = '�Resetear todos los datos del usuario?';
  SFileRunDialogTitle = 'Ejecutar';
  SNoName = '(Sin Nombre)';      
  SErrorActionManagerNotAssigned = 'ActionManager debe estar asignado primero';
  SAddRemoveButtons = '&A�adir o quitar Botones';
  SResetActionToolBar = 'Reset Toolbar';
  SCustomize = '&Personalizar';
  SSeparator = 'Separador';
  SCirularReferencesNotAllowed = 'Referencias circulares no permitidas';
  SCannotHideActionBand = '%s no permite hiding(esconderse)';
  SErrorSettingCount = 'Error estableciendo %s.Count';
  SListBoxMustBeVirtual = 'Listbox (%s) style debe establecerse como virtual para establecer (set) Count';
  SUnableToSaveSettings = 'No se pueden grabar las opciones settings';
  SRestoreDefaultSchedule = '�Le gustar�a resetear al valor por defecto de Priority Schedule(agenda de prioridades)?';
  SNoGetItemEventHandler = 'No hay manejador (handler) para el evento OnGetItem asignado';
  SInvalidColorMap = 'Colormap no v�lido. Este ActionBand requiriere ColorMaps de tipo TCustomActionBarColorMapEx';
  SDuplicateActionBarStyleName = 'Un estilo llamado %s ha sido registrado previamente';
  SStandardStyleActionBars = 'Estilo Standard';
  SXPStyleActionBars = 'XP Style';
  SActionBarStyleMissing = 'No hay un (unit) de estilo ActionBand unit presente in la cla�sula uses.'#13 +
    'Tu aplicaci�n debe incluir XPStyleActnCtrls, StdStyleActnCtrls o ' +
    'una tercera aplicaci�n que incluya ActionBand en sus cl�usulas uses';
    //hasta aqui llega el archivo de delphi 6
  sParameterCannotBeNil = '%s parameter in call to %s cannot be nil';
  SInvalidColorString = 'Invalid Color string';

  SInvalidPath = '"%s" is an invalid path';
  SInvalidPathCaption = 'Invalid path';

  SANSIEncoding = 'ANSI';
  SASCIIEncoding = 'ASCII';
  SUnicodeEncoding = 'Unicode';
  SBigEndianEncoding = 'Big Endian Unicode';
  SUTF8Encoding = 'UTF-8';
  SUTF7Encoding = 'UTF-7';
  SEncodingLabel = 'Encoding:';

  sCannotAddFixedSize = 'Cannot add columns or rows while expand style is fixed size';
  sInvalidSpan = '''%d'' is not a valid span';
  sInvalidRowIndex = 'Row index, %d, out of bounds';
  sInvalidColumnIndex = 'Column index, %d, out of bounds';
  sInvalidControlItem = 'ControlItem.Control cannot be set to owning GridPanel';
  sCannotDeleteColumn = 'Cannot delete a column that contains controls';
  sCannotDeleteRow = 'Cannot delete a row that contains controls';
  sCellMember = 'Member';
  sCellSizeType = 'Size Type';
  sCellValue = 'Value';
  sCellAutoSize = 'Auto';
  sCellPercentSize = 'Percent';
  sCellAbsoluteSize = 'Absolute';
  sCellColumn = 'Column%d';
  sCellRow = 'Row%d';

  STrayIconRemoveError = 'Cannot remove shell notification icon';
  STrayIconCreateError = 'Cannot create shell notification icon';

  SPageControlNotSet = 'PageControl must first be assigned';

  SWindowsVistaRequired = '%s requires Windows Vista or later';
  SXPThemesRequired = '%s requires themes to be enabled';

  STaskDlgButtonCaption = 'Button%d';
  STaskDlgRadioButtonCaption = 'RadioButton%d';
  SInvalidTaskDlgButtonCaption = 'Caption cannot be empty';

implementation

end.
