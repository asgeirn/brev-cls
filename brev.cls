% $Id: brev.cls,v 1.1 1996/04/16 20:19:20 ambolt Rel ambolt $

% A little letter class for personal letters.  It is called ``brev''
% because that is the Norwegian name for letter, and the name
% ``letter'' is used. 

% The special characteristics of this style is the addresses field at
% the top of the first page. This one is placed within a 7cm by 7cm
% picture element adjusted to the paper edge at the top and 1in from
% the paper edge at the left.  The recipient address should be placed
% within the window of window envelopes, and the sender address above
% the window.
% The class is made and tested with A4 paper and 10pt font, but should
% be portable to other dimensions as well.

% The envelope used for defining this class has the following
% characteristics:
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
% With thanks to Dag Langmyhr <dag@ifi.uio.no>

%% Identification part:

\NeedsTeXFormat{LaTeX2e}[1994/12/01]

\ProvidesClass{brev}[1996/04/16 $Revision: 1.1 $ Klasse for private brev]

%% Initial code part:

%% Options declaration part:

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}

%% Options execution part:

\ProcessOptions

%% Package loading part:

\LoadClass[a4paper]{letter}

% Modify the first page layout:

\def \ps@firstpage{%
  \setlength\unitlength{1cm}
  \newlength{\topwidth}
  \setlength\topwidth{\textwidth}
  \addtolength\topwidth{\oddsidemargin}
  \newlength{\topadjust}
  \setlength\topadjust{\topmargin}
  \addtolength\topadjust{1in}  % The 1in space given in the dvi drivers
  \addtolength\topadjust{\baselineskip} % The height of one line of text
  \addtolength\topadjust{-7cm} % The height of the picture environment
  \def \@evenhead{\raisebox{\topadjust}[0pt][0pt]{%
      \hspace*{-\oddsidemargin}\hbox to \topwidth{\begin{picture}(7,7)
        \put(0,1.5){\makebox(0,0)[cl]{\begin{minipage}{7cm}
          \toname\\
          \toaddress
          \end{minipage}}}
        \put(0,3.5){\makebox(0,0)[bl]{\begin{minipage}{7cm}
          \fromname\\
          \fromaddress
          \end{minipage}}}
      \end{picture}\hss\raisebox{1cm}{\fromlocation,\ \@date}}}%
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
  #1\par\nobreak}

\pagestyle{plain}


