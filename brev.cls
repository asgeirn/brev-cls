% $Id: brev.cls,v 2.9 1998/03/30 21:03:07 ambolt Exp $

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
% This class tries to look like the Norwegian standard letter, but is
% probably wrong. 
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

\ProvidesClass{brev}[$Date$ Klasse for private brev]

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

%% Options declaration part:

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

\def\postalm@gic#1 #2\relax{\MakeUppercase{#1}\ \ \MakeUppercase{#2}}

\def\addressm@gic#1\\#2\relax{%
  \ifx\relax#2\relax          % Er #2 tom?
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
      \end{picture}\hss\raisebox{4cm}{%
          \ifx\@empty\fromlocation \else \fromlocation,\ \fi \@date}}}%
          % In case you don't use \location
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

% End of brev.cls
