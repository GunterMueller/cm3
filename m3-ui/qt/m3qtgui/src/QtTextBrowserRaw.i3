(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtTextBrowserRaw;


IMPORT Ctypes AS C;




<* EXTERNAL New_QTextBrowser0 *>
PROCEDURE New_QTextBrowser0 (parent: ADDRESS; ): QTextBrowser;

<* EXTERNAL New_QTextBrowser1 *>
PROCEDURE New_QTextBrowser1 (): QTextBrowser;

<* EXTERNAL Delete_QTextBrowser *>
PROCEDURE Delete_QTextBrowser (self: QTextBrowser; );

<* EXTERNAL QTextBrowser_source *>
PROCEDURE QTextBrowser_source (self: QTextBrowser; ): ADDRESS;

<* EXTERNAL QTextBrowser_isBackwardAvailable *>
PROCEDURE QTextBrowser_isBackwardAvailable (self: QTextBrowser; ): BOOLEAN;

<* EXTERNAL QTextBrowser_isForwardAvailable *>
PROCEDURE QTextBrowser_isForwardAvailable (self: QTextBrowser; ): BOOLEAN;

<* EXTERNAL QTextBrowser_clearHistory *>
PROCEDURE QTextBrowser_clearHistory (self: QTextBrowser; );

<* EXTERNAL QTextBrowser_historyTitle *>
PROCEDURE QTextBrowser_historyTitle (self: QTextBrowser; arg2: C.int; ):
  ADDRESS;

<* EXTERNAL QTextBrowser_historyUrl *>
PROCEDURE QTextBrowser_historyUrl (self: QTextBrowser; arg2: C.int; ):
  ADDRESS;

<* EXTERNAL QTextBrowser_backwardHistoryCount *>
PROCEDURE QTextBrowser_backwardHistoryCount (self: QTextBrowser; ): C.int;

<* EXTERNAL QTextBrowser_forwardHistoryCount *>
PROCEDURE QTextBrowser_forwardHistoryCount (self: QTextBrowser; ): C.int;

<* EXTERNAL QTextBrowser_openExternalLinks *>
PROCEDURE QTextBrowser_openExternalLinks (self: QTextBrowser; ): BOOLEAN;

<* EXTERNAL QTextBrowser_setOpenExternalLinks *>
PROCEDURE QTextBrowser_setOpenExternalLinks
  (self: QTextBrowser; open: BOOLEAN; );

<* EXTERNAL QTextBrowser_openLinks *>
PROCEDURE QTextBrowser_openLinks (self: QTextBrowser; ): BOOLEAN;

<* EXTERNAL QTextBrowser_setOpenLinks *>
PROCEDURE QTextBrowser_setOpenLinks (self: QTextBrowser; open: BOOLEAN; );

<* EXTERNAL QTextBrowser_setSource *>
PROCEDURE QTextBrowser_setSource (self: QTextBrowser; name: ADDRESS; );

<* EXTERNAL QTextBrowser_backward *>
PROCEDURE QTextBrowser_backward (self: QTextBrowser; );

<* EXTERNAL QTextBrowser_forward *>
PROCEDURE QTextBrowser_forward (self: QTextBrowser; );

<* EXTERNAL QTextBrowser_home *>
PROCEDURE QTextBrowser_home (self: QTextBrowser; );

<* EXTERNAL QTextBrowser_reload *>
PROCEDURE QTextBrowser_reload (self: QTextBrowser; );

TYPE QTextBrowser = ADDRESS;

END QtTextBrowserRaw.
