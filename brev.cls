% $Id: brev.cls,v 1.7 1996/05/24 16:09:34 ambolt Exp ambolt $

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
% both in E5 og E65 envelopes.  These are 4mm lines placed 10.5cm and
% 14.8cm from the top edge of the paper.
% The class is made and tested with A4 paper and 10pt font, but should
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

%% Identification part:

\NeedsTeXFormat{LaTeX2e}[1995/12/01]

\ProvidesClass{brev}[1996/05/26 $Revision: 1.7 $ Klasse for private brev]

%% Initial code part:

\newlength{\topwidth}
\newlength{\topadjust}

%% Options declaration part:

%% Options execution part:

%% Package loading part:

\LoadClassWithOptions{letter}

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
      \hspace*{-\oddsidemargin}\hbox to \topwidth{\begin{picture}(7,7)
        \put(0,1.5){\makebox(0,0)[cl]{\begin{minipage}{7cm}
          \toname\\
          \toaddress
          \end{minipage}}}
        \put(0,4){\makebox(0,0)[bl]{\begin{minipage}{7cm}
          \ifx\@empty\fromname % In case you don't use \name
          \else
             \fromname\\
          \fi
          \fromaddress
          \end{minipage}}}
        % The following folding lines should be placed 0.4mm from the
	% left edge of the paper.  Hope your printer can handle that!
        \put(-2.5,-3.5){\line(1,0){0.4}}
        \put(-2.5,-7.8){\line(1,0){0.4}}
      \end{picture}\hss\raisebox{1cm}{%
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
  {\bf#1\par\nobreak}}

\pagestyle{plain}


