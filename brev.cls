% $Id$

% A little letter class for personal letters.  It is called ``brev''
% because that is the Norwegian name for letter, and the name
% ``letter'' is used. 

% The class is distributed for free use and modifications by anyone,
% private, educational or commercial.  But I would like to hear about
% any improvements!

% Written by Asgeir Nilsen <ambolt@stud.ntnu.no>.

%% Identification part:

\NeedsTeXFormat{LaTeX2e}[1994/12/01]

\ProvidesClass{brev}[1996/04/16 $Revision: 1.0 $ Klasse for private brev]

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
  \def \@evenhead{\raisebox{-3cm}[0pt][0pt]{%
      \hspace*{-\oddsidemargin}\hbox to \topwidth{\begin{picture}(7,7)
        \put(0,1.5){\makebox(0,0)[cl]{\begin{minipage}{7cm}
          \toname\\
          \toaddress
          \end{minipage}}}
        \put(0,3,5){\makebox(0,0)[bl]{\begin{minipage}{7cm}
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


