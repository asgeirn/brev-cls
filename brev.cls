% $Id: brev.cls,v 2.11 1998/04/24 11:17:52 ambolt Exp $

% Note: This class loads the babel package.
% Specify the language in the \documentclass command:
% \documentclass[norsk,...]{brev}
% or
% \documentclass[nynorsk,...]{brev}
% or
% \documentclass[english,...]{brev}

% This class introduces two new commands:
% \yourref{text}        Inserts a ``Your ref'' caption with text at an
%                       appropriate place.
% \ourref{text}         Does the same for ``Our ref''.

% This class also supports mailing labels via two class arguments and
% one new command.
% The label sheets supported are the ones with 7x3 labels on letter
% paper, and 8x3 labels on A4 paper.
% 
% labels                Creates mailing labels for the recipient of
%                       each letter environment.  To create extra
%                       labels, insert empty letter environments.
% returnlabels          Creates mailing labels for the return
%                       addresses of each letter environment.
% \skiplabels{num}      Skips the given number of labels before
%                       starting populating the labels.  This is handy
%                       for using the same label sheet several times.
%                       WARNING: If you insert a label sheet with some
%                       of the labels removed, the paper might jam in
%                       your printer.  Use with caution!
%                       This command must be given in the preamble.

% A little letter class for personal letters.  It is called ``brev''
% because that is the Norwegian name for letter, and the class
% ``letter'' is the standard LaTeX letter class. 

% The special characteristics of this class is the addresses field at
% the top of the first page. This one is placed within a 7cm by 8cm
% picture element adjusted to the paper edge at the top and 1in from
% the paper edge at the left.  The recipient address should be placed
% within the window of window envelopes, and the sender address above
% the window.
% Two folding lines is also provided for folding the letter correctly
% both in C5 og E65 envelopes.  These lines are placed 10.5cm and
% 14.8cm from the top edge of the paper. 
% The class is made and tested with A4 paper, but should be portable
% to other dimensions as well.  

% The envelope used for defining this class is a E65 window envelope
% with the following characteristics:
% +------------------------------+
% |                   |          |
% | +-----------+ -   A          |
% | |           | B   |          |
% | +-----------+ -   -          |
% |                              |
% +------------------------------+
% Dimension A (from top edge of env. to bot. edge of win): 7cm
% Dimension B (height of window)                         : 3cm

% The class is distributed for free use and modifications by anyone,
% private, educational or commercial.  But I would like to hear about
% any improvements!

% This package has shamelessly stolen the mailing label definitions
% from Sebastian Rahtz' labels package.  The original copyright is
% within the redefinition of letter.cls' \startlabels at the end of
% this file.

% There is a mailing list for news and updates for this class.  Send a
% mail to majordomo@mercury.kje.ntnu.no with the text 
% `subscribe brev-cls-list <your@email.address>' in the TEXT (NOT
% subject) of the message.

% The newest version of this class is always available at
% ftp://mercury.kje.ntnu.no/pub/latex/brev.cls. 

% Written by Asgeir Nilsen <ambolt@stud.ntnu.no>
% With thanks to 
%   Dag Langmyhr <dag@ifi.uio.no>
%   Svend Tollak Munkejord <stm@stud.ntnu.no>
%   Hans Peter Verne <hpv@kjemi.uio.no>
%   Harald Hanche-Olsen <hanche@math.ntnu.no>
%   Morten Simonsen <mortensi@idt.ntnu.no>

%% Latex requirement part:

\NeedsTeXFormat{LaTeX2e}[1994/12/01]

%% Identification part:

\ProvidesClass{brev}[1998/05/05 Class for private letters]

%% Initial code part:

\newlength{\topwidth}
\newlength{\topadjust}
\newlength{\box@width}
\newlength{\half@box}
\raggedright
\newcommand*{\ourref}[1]{\def\oref{#1}}
\newcommand*{\yourref}[1]{\def\yref{#1}}
\ourref{}
\yourref{}
\newif\ifl@bels
\newif\ifl@@bels
\newif\ifl@@@bels
\l@belsfalse
\l@@belsfalse
\l@@@belsfalse

%% Options declaration part:

\DeclareOption{returnlabels}{\l@belstrue\l@@@belstrue}
\DeclareOption{labels}{\l@belstrue\l@@belstrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}

%% Options execution part:

\ProcessOptions

%% Package loading part:

\LoadClass[a4paper]{letter}
\RequirePackage{babel}

%% Babel part:

\addto\extrasnynorsk{%
  \def\captionoref{{\small V{\aa}r ref.:}}%
  \def\captionyref{{\small Dykkar ref.:}}%
}
\addto\extrasnorsk{%
  \def\captionoref{{\small V{\aa}r ref.:}}%
  \def\captionyref{{\small Deres ref.:}}%
}
\addto\extrasenglish{%
  \def\captionoref{{\small Our ref.:}}%
  \def\captionyref{{\small Your ref.:}}%
}

%% Modification part:

\addtolength{\textwidth}{\oddsidemargin}
\setlength{\oddsidemargin}{0pt}
\addtolength{\textwidth}{\evensidemargin}
\setlength{\evensidemargin}{0pt}
\setlength{\longindentation}{0pt}

% Address magic

\def\postalm@gic#1 #2\relax{%
  \ifx \relax#1\relax       % Is #1 a space?
    \postalm@gic#2\relax
  \else
    \MakeUppercase{#1}\ \ \MakeUppercase{#2}
  \fi}

\def\addressm@gic#1\\#2\relax{%
  \ifx\relax#2\relax          % Is #2 empty?
    \rule{0pt}{0pt}\\\postalm@gic#1\relax
  \else
    #1\\\addressm@gic#2\relax
  \fi}

% Modify the first page layout:

\def \ps@firstpage{%
  \setlength\unitlength{1mm}
  \setlength\topwidth{\textwidth}
  \addtolength\topwidth{\oddsidemargin}
  \setlength\topadjust{\topmargin}
  \addtolength\topadjust{1in}  % The 1in space given in the dvi drivers
  \addtolength\topadjust{\baselineskip} % The height of one line of text
  \addtolength\topadjust{-7cm} % The height of the picture environment
  \setlength\box@width{\textwidth}
  \divide\box@width\unitlength % This will be the width of the picture
                               % environment
  \setlength\half@box{\textwidth}
  \addtolength\half@box{-8cm}  % This is the room left for the
                               % \telephone field without clashing
                               % with the window of the envelope.
  \def \@evenhead{\raisebox{\topadjust}[0pt][0pt]{%
      \hspace*{-\oddsidemargin}\hbox to \topwidth{\begin{picture}(70,\number\box@width)
        \put(0,17.5){\makebox(0,0)[cl]{\begin{minipage}{8cm}
          \toname\\
          \expandafter\addressm@gic\toaddress\\\relax
          \end{minipage}}}
        \put(0,40){\makebox(0,0)[bl]{\begin{minipage}{\textwidth}
          \ifx\@empty\fromname % In case you don't use \name
          \else
             \fromname\\
          \fi
          \expandafter\addressm@gic\fromaddress\\\relax
          \end{minipage}}}
        \put(\number\box@width,40){\makebox(0,0)[br]{\begin{minipage}{\half@box}
          \raggedleft
          \ifx\@empty\fromlocation \else \fromlocation,\ \fi \@date
          % In case you don't use \location
          \end{minipage}}}
        \ifx\@empty\telephonenum\else
          \put(\number\box@width,0){\makebox(0,0)[br]{\begin{minipage}{\half@box}
             \raggedleft
             \telephonenum
          \end{minipage}}}
        \fi
        \ifx\@empty\yref\else %
          {\put(0,-10){\makebox(0,0)[cl]{\captionyref\ \yref}}}
        \fi
        \ifx\@empty\oref\else %
          {\put(70,-10){\makebox(0,0)[cl]{\captionoref\ \oref}}}
        \fi
        % These two folding lines are placed at 10.4mm from the left
        % edge of the paper, running left way off the edge. 
        \put(-15,-35){\line(-1,0){20}}
        \put(-15,-78){\line(-1,0){20}}
      \end{picture}}}%
  }%
  \def \@oddhead{\@evenhead}%
  \def \@oddfoot{}\def \@evenfoot{}%
}

% Modify layout of other pages:

\def \ps@plain{%
  \def \@evenhead{}\def \@oddhead{}%
  \def \@evenfoot{\normalfont\rmfamily\normalsize\mdseries\upshape\hfil
        -- \thepage\ --\hfil}%
  \def \@oddfoot{\@evenfoot}%
}

% Modify \opening:

\renewcommand{\opening}[1]{%
  \thispagestyle{firstpage} 
  \vspace*{0,7cm}
  {\textbf{#1}\par\nobreak}}

% Modify \closing:

\renewcommand{\closing}[1]{\par\nobreak\vspace{5\parskip}%
  \stopbreaks
  \noindent
  \ifx\@empty\fromaddress\else
  \hspace*{\longindentation}\fi
  \raggedright
  \ignorespaces #1\\[6\medskipamount]%
  \ifx\@empty\fromsig
  \fromname
  \else \fromsig \fi\strut
  \par}

\pagestyle{plain}

% Mailing labels:

\renewcommand*{\startlabels}{\pagestyle{empty}%
%% 
%% This is file `labels.sty',
%% generated with the docstrip utility.
%% 
%% The original source files were:
%% 
%% labels.dtx  (with options: `package')
%% Copyright (C) 1993-1994-1995 by Sebastian Rahtz 
%% All rights reserved. 
%% 
%% Permission is granted to to customize the declarations in this file to 
%% serve the needs of your installation. However, no permission is 
%% granted to distribute a modified version of this file under its 
%% original name. 
%% 
\def\fileversion{10}
\def\docdate{1995/06/22}
\def\filedate{1995/06/22}
\def\LabelsFileInfo{\filedate\space\fileversion}
%% File: labels.dtx  Copyright (C) 1993-1994-1995 by Sebastian Rahtz
%%   and Grant Gustafson
%% All rights reserved.
\newcount\LabelCols
\newcount\LabelRows
\newdimen\LeftBorder
\newdimen\RightBorder
\newdimen\TopBorder
\newdimen\BottomBorder
\newcount\numberoflabels
\newdimen\label@width
\newdimen\label@height
\newdimen\half@label
\newdimen\area@width
\newdimen\addr@width
\newdimen\LabTmp
\newsavebox{\this@label}
\newcount\label@number
\newcount\skip@labels
\newcount\l@so@far
\newif\ifLabelGrid
\newif\iffirst@label
\newif\ifLabelInfo
\first@labeltrue
\LabelGridfalse
\LabelInfofalse
\ifdim\paperwidth=210mm\relax%
   \LabelCols=3\relax\LabelRows=8\relax% a4paper
\else
   \LabelCols=3\relax\LabelRows=7\relax% letterpaper
\fi%
\LeftBorder=8mm
\RightBorder=8mm
\TopBorder=9mm
\BottomBorder=2mm
\textwidth=\paperwidth
\textheight=\paperheight
\topmargin=-1in
\headheight=0em
\headsep=0em
\topskip=0em
\footskip=0em
\oddsidemargin=-1in
\evensidemargin=-1in
\pagestyle{empty}
\parindent=0em
\parskip=0pt
\def\@LabelSetup{%
\global\label@width\textwidth%
\global\divide\label@width by\LabelCols%
\global\label@height\textheight%
\global\advance\label@height by-\TopBorder%
\global\advance\label@height by-\BottomBorder%
\global\divide\label@height by\LabelRows%
\global\topmargin=-1in\global\advance\topmargin by\TopBorder%
\global\area@width=\label@width%
\global\advance\area@width by -\LeftBorder%
\global\advance\area@width by -\RightBorder%
\ifLabelGrid%
\global\advance\area@width by-2\fboxsep%
\global\advance\area@width by-2\fboxrule%
\fi%
\ifLabelGrid%
\global\advance\label@height by-2\fboxsep%
\global\advance\label@height by-2\fboxrule%
\fi%
\global\half@label=\label@height\divide\half@label by2\relax
\global\label@number=1\relax
}
\def\LabelSetup{\@LabelSetup%
\ifLabelInfo
   \typeout{Control sequences adjustable in the preamble:}
   \typeout{\LabelRows=\the\LabelRows}
   \typeout{\LabelCols=\the\LabelCols}
   \TypeoutBlurb{\TopBorder}{\TopBorder}
   \TypeoutBlurb{\BottomBorder}{\BottomBorder}
   \TypeoutBlurb{\LeftBorder}{\LeftBorder}
   \TypeoutBlurb{\RightBorder}{\RightBorder}
   \typeout{Computed values:}
   \TypeoutBlurb{Label Width}{\label@width}
   \TypeoutBlurb{Label Height}{\label@height}
%\else
%   \typeout{To print info, put `\protect\LabelInfotrue' in the preamble}
\fi
}
\numberoflabels=1%
\def\sticky@label{\l@so@far=0%
\loop\ifnum\l@so@far<\numberoflabels\advance\l@so@far by 1\make@label%
\repeat}
\def\make@label{%
\ifLabelGrid%
 \let\boxing@type\framebox%
\else%
 \let\boxing@type\makebox%
\fi%
\settowidth{\LabTmp}{\usebox{\this@label}}%
\ifdim\LabTmp=0cm\let\action=\relax\else\let\action=\BuildB@x\fi%
\advance\LabTmp by -\area@width%
\ifdim\LabTmp>0cm\relax\fi%
\settoheight{\LabTmp}%
{\begin{tabular}{l}\usebox{\this@label}\end{tabular}}%
\advance\LabTmp by -\half@label%
\ifdim\LabTmp>0cm\relax%
\LabTmp=2\LabTmp\fi%
\ifnum\skip@labels<\sk@pped\let\action=\BuildB@x\fi%
\action
}
\def\BuildB@x{%
\boxing@type[\label@width][c]{%
\rule{0pt}{\label@height}%
\raisebox{\half@label}[0pt][0pt]{%
\rule{\LeftBorder}{0pt}%
\usebox{\this@label}%
\rule{\RightBorder}{0pt}%
}}%
\ifnum\skip@labels<\sk@pped\message{x}\else\message{+}\fi%
\ifnum\label@number=\LabelCols%
\message{|}%
\endgraf\nointerlineskip%
\global\label@number=1\else\global\advance\label@number by 1\fi%
}%
%
\ifnum\theskiplabels>0
\numberoflabels=\theskiplabels
\addresslabel{\rule{0pt}{0pt}}
\numberoflabels=1
\fi
}

\newcount\@Milli
\def\ToMilli#1{\@Milli=#1\advance\@Milli by93225\relax
\divide\@Milli by 186450\relax}
\newcommand{\genericlabel}[1]{%
\iffirst@label\LabelSetup\first@labelfalse\fi%
\savebox{\this@label}{#1}\sticky@label\@gobblecr}
\long\def\L@dblarg#1{\@ifnextchar[{#1}{\L@xdblarg{#1}}}
\long\def\L@xdblarg#1#2{#1[]{#2}}
\long\def\addresslabel{\L@dblarg{\@addresslabel}}
\long\def\@addresslabel[#1]#2{\genericlabel{#1%
\begin{tabular}{@{}p{\area@width}@{}}\raggedright #2\end{tabular}}}
\long\def\boxedaddresslabel{\L@dblarg{\@boxedaddresslabel}}
\long\def\@boxedaddresslabel[#1]#2{\genericlabel{#1%
\addr@width=\area@width\advance\addr@width by-2\fboxsep%
\advance\addr@width by-2\fboxrule\fbox{%
\begin{tabular}{@{}p{\addr@width}@{}}\raggedright #2\end{tabular}}}}
\newcount\sk@pped
\newcounter{skiplabels}
\def\skiplabels#1{\setcounter{skiplabels}{#1}}

\renewcommand*{\mlabel}[2]{%
  \ifx#1\@empty\else\addresslabel{\expandafter\addressm@gic#1\\\relax}\fi
  \ifl@@bels\addresslabel{\expandafter\addressm@gic#2\\\relax}\fi}

\ifl@bels\makelabels\fi
\ifl@@@bels\renewcommand*{\returnaddress}{\fromname\\\fromaddress}\fi

% End of brev.cls
