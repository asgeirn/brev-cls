% $Id: brev.cls,v 2.1 1996/09/13 06:12:54 ambolt Rel ambolt $

% A little letter class for personal letters.  It is called ``brev''
% because that is the Norwegian name for letter, and the class
% ``letter'' is the standard LaTeX letter class. 

% The special characteristics of this style is the addresses field at
% the top of the first page. This one is placed within a 7cm by 7cm
% picture element adjusted to the paper edge at the top and 1in from
% the paper edge at the left.  The recipient address should be placed
% within the window of window envelopes, and the sender address above
% the window.
% Two folding lines is also provided for folding the letter correctly
% both in E5 og E65 envelopes.  These are lines placed 10.5cm and
% 14.8cm from the top edge of the paper. 
% This class tries to look like the Norwegian standard letter, but is
% probably wrong. 
% The class is made and tested with A4 paper and 11pt font, but should
% be portable to other dimensions as well. 

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

% Written by Asgeir Nilsen <ambolt@stud.ntnu.no>
% With thanks to 
%   Dag Langmyhr <dag@ifi.uio.no>
%   Svend Tollak Munkejord <stm@stud.unit.no>

%% Latex requirement part:

\NeedsTeXFormat{LaTeX2e}[1994/12/01]

%% Identification part:

\ProvidesClass{brev}[1996/10/14 $Revision: 2.1 $ Klasse for private brev]

%% Initial code part:

\newlength{\topwidth}
\newlength{\topadjust}
\raggedright

%% Options declaration part:

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}

%% Options execution part:

\ProcessOptions

%% Package loading part:

\LoadClass[a4paper]{letter}

%% Modification part:

\addtolength{\textwidth}{\oddsidemargin}
\setlength{\oddsidemargin}{0pt}
\addtolength{\textwidth}{\evensidemargin}
\setlength{\evensidemargin}{0pt}
\setlength{\longindentation}{0pt}

% Modify the first page layout:

\def \ps@firstpage{%
  \setlength\unitlength{1cm}
  \setlength\topwidth{\textwidth}
  \addtolength\topwidth{\oddsidemargin}
  \setlength\topadjust{\topmargin}
  \addtolength\topadjust{1in}  % The 1in space given in the dvi drivers
  \addtolength\topadjust{\baselineskip} % The height of one line of text
  \addtolength\topadjust{-7cm} % The height of the picture environment
  \def \@evenhead{\raisebox{\topadjust}[0pt][0pt]{%
      \hspace*{-\oddsidemargin}\hbox to \topwidth{\begin{picture}(7,8)
        \put(0,1.75){\makebox(0,0)[cl]{\begin{minipage}{8cm}
          \toname\\
          \toaddress
          \end{minipage}}}
        \put(0,4){\makebox(0,0)[bl]{\begin{minipage}{8cm}
          \ifx\@empty\fromname % In case you don't use \name
          \else
             \fromname\\
          \fi
          \fromaddress
          \end{minipage}}}
	% These two folding lines are placed at 5.4mm from the left
	% edge of the paper, running left way off the edge. 
        \put(-2,-3.5){\line(-1,0){1}}
        \put(-2,-7.8){\line(-1,0){1}}
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
  \parbox{\indentedwidth}{\raggedright
       \ignorespaces #1\\[6\medskipamount]%
       \ifx\@empty\fromsig
           \fromname
       \else \fromsig \fi\strut}%
   \par}

\pagestyle{plain}

% End of brev.cls
