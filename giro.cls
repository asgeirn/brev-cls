% giro.cls,v 1.6 2001/10/29 19:26:05 ambolt Exp

%    This program is free software; you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation; either version 2 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program; if not, write to the Free Software
%    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%
%% Latex requirement part:
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
%
%% Identification part:
%
\ProvidesClass{giro}[2022/05/09 v1.7 Klasse for utfylling av giro]
%
%% Initial code part:
%
%\newcommand{\name}[1]{\def\fromname{#1}}
%\newcommand{\address}[1]{\def\fromaddress{#1}}
%\newcommand{\location}[1]{\def\fromlocation{#1}}
%\name{}
%\address{}
%\location{}
\def\@mount(#1,#2){\global\def\AmountIP{#1}\global\def\AmountFP{#2}}
\newcommand{\amount}[2][]{\global\def\TheAmount{#2}\global\def\AmountCS{#1}\@mount(#2)}
\newcommand{\account}[1]{\global\def\fromaccount{#1}}
\newcommand{\forfall}[1]{\global\def\Forfall{#1}}
\newcommand{\gjelder}[1]{\global\def\Regarding{#1}}
\newcommand{\kid}[1]{\global\def\TheKID{#1}}
\account{}
\def\Letter@Date(#1/#2/#3){%
  \ifx\@empty#1\ClassWarning{giro}{Invalid date for \protect\LetterDate}\else%
  \ifx\@empty#2\ClassWarning{giro}{Invalid date for \protect\LetterDate}\else%
  \ifx\@empty#3\ClassWarning{giro}{Invalid date for \protect\LetterDate}\else%
  \def\Date@Year{#1}\def\Date@Month{#2}\def\Date@Day{#3}\fi\fi\fi}
\newcommand*{\LetterDate}[1]{\Letter@Date(#1)}
%
%% Package loading part:
%
%\LoadClassWithOptions{article}
\LoadClassWithOptions{letter}
%\RequirePackage[latin1]{inputenc}
%\RequirePackage[T1]{fontenc}
%%%
\pagestyle{empty}
\newsavebox{\lettercontents}
\newlength{\Letter@width}
\setlength{\Letter@width}{\paperwidth}
\newlength{\Letter@leftmargin}
\setlength{\Letter@leftmargin}{\oddsidemargin}
%\addtolength{\Letter@leftmargin}{1in}
\newlength{\Letter@rightmargin}
\setlength{\Letter@rightmargin}{\paperwidth}
\addtolength{\Letter@rightmargin}{-1in}
\addtolength{\Letter@width}{-\Letter@leftmargin}
\addtolength{\Letter@width}{-1in}
\newlength{\Letter@top}
\setlength{\Letter@top}{\paperheight}
\addtolength{\Letter@top}{-75mm}
\setlength{\voffset}{0pt}
\setlength{\topmargin}{-1in}
\setlength{\headheight}{0pt}
\setlength{\headsep}{0pt}
\setlength{\topskip}{0pt}
\setlength{\footskip}{0pt}
\setlength{\hoffset}{0pt}
\setlength{\parindent}{0pt}
\setlength{\oddsidemargin}{-1in}
\setlength{\evensidemargin}{-1in}
\setlength{\unitlength}{1mm}
\setlength{\textwidth}{\paperwidth}
\setlength{\textheight}{\paperheight}
\newlength{\Letter@toaddress}
\newlength{\Letter@fromaddress}
\newlength{\middlefoldline}
\newlength{\topfoldline}
\newlength{\picwidth}
\newlength{\picheight}
\setlength{\picwidth}{\textwidth}
\setlength{\picheight}{\textheight}
\setlength{\Letter@toaddress}{\textheight}
\addtolength{\Letter@toaddress}{-55mm}
\setlength{\Letter@fromaddress}{\textheight}
\addtolength{\Letter@fromaddress}{-38mm}
\newlength{\Rule@width}
\setlength{\Rule@width}{\picwidth}
\addtolength{\Rule@width}{-22mm}
\divide\Rule@width\unitlength
\setlength{\middlefoldline}{\textheight}
\divide\middlefoldline by 2
\divide\middlefoldline\unitlength
\setlength{\topfoldline}{\textheight}
\divide\topfoldline by 3
\multiply\topfoldline by 2
\divide\topfoldline\unitlength
\divide\picwidth\unitlength
\divide\picheight\unitlength
\divide\Letter@leftmargin\unitlength
\divide\Letter@rightmargin\unitlength
\divide\Letter@top\unitlength
\divide\Letter@toaddress\unitlength
\divide\Letter@fromaddress\unitlength
\newenvironment{giro}[1]%
%\begin:
{\def\Mottaker{#1}
  \amount{0,00}
  \forfall{}
  \gjelder{}
  \kid{}
  \begin{letter}{#1}
    \begin{picture}(\number\picwidth,\number\picheight)
% Brevdel:
      \put(20,\number\Letter@toaddress){\makebox(0,0)[l]{\begin{minipage}[c][20mm][c]{85mm}
            #1
          \end{minipage}}}%
      \put(20,\number\Letter@fromaddress){\makebox(0,0)[bl]{\begin{minipage}{\textwidth}
            \ifx\@empty\fromname % In case you don't use \name
            \else %
            \fromname\\
            \fi
            \fromaddress
          \end{minipage}}}%
      \put(\number\Letter@rightmargin,\number\Letter@fromaddress){\makebox(0,0)[br]{\begin{minipage}{85mm}
            \raggedleft\ifx\@empty\fromlocation \else \fromlocation,\ \fi%
                                % In case you don't use \location
            {\ifx\@empty\Date@Year\else%
              \def\year{\Date@Year}%
              \def\month{\Date@Month}%
              \def\day{\Date@Day}\fi%
              \@date}
          \end{minipage}}}%
%      \put(0,0){\vector(1,0){\number\box@width}}%
%      \put(0,0){\vector(0,1){\number\box@height}}%
      \put(15,\number\topfoldline){\makebox(0,0)[cl]{\line(-1,0){20}}}%
      \put(15,\number\middlefoldline){\makebox(0,0)[cl]{\line(-1,0){20}}}%
% Tekst:
      \begin{lrbox}{\lettercontents}\begin{minipage}{\Letter@width}
}%
%\end:
{%
  \end{minipage}\end{lrbox}
  \put(\number\Letter@leftmargin,\number\Letter@top){\makebox(0,0)[tl]{\usebox{\lettercontents}}}
  \put(11,113){\line(1,0){\number\Rule@width}}
  \put(11,110){}
% Girodel:
  \put(15,105){\makebox(0,0)[bl]{\fontencoding{OT1}\fontfamily{ocrb}\selectfont \fromaccount}}
  \put(113,105){\makebox(0,0)[br]{\fontencoding{OT1}\fontfamily{ocrb}\selectfont \TheAmount}}
  \put(0,21.5){\makebox(0,0)[bl]{\fontencoding{OT1}\fontfamily{ocrb}\selectfont H}}
  \put(131,21.5){\makebox(0,0)[bl]{\fontencoding{OT1}\fontfamily{ocrb}\selectfont \fromaccount}}
  \put(70,21.5){\makebox(0,0)[br]{\fontencoding{OT1}\fontfamily{ocrb}\selectfont \TheKID}}
  \put(182,96){\makebox(0,0){\fontencoding{OT1}\fontfamily{ocrb}\selectfont \Forfall}}
  \put(102,21.5){\makebox(0,0)[br]{\fontencoding{OT1}\fontfamily{ocrb}\selectfont \AmountIP}}
  \put(106,21.5){\makebox(0,0)[bl]{\fontencoding{OT1}\fontfamily{ocrb}\selectfont \AmountFP}}
  \put(119,21.5){\makebox(0,0)[b]{\fontencoding{OT1}\fontfamily{ocrb}\selectfont \AmountCS}}
  \put(15,65){\makebox(0,0)[tl]{\begin{minipage}[t][22mm][c]{80mm}
        \texttt{\Mottaker}
      \end{minipage}}}
  \put(115,65){\makebox(0,0)[tl]{\begin{minipage}[t][22mm][c]{80mm}
        \texttt{\ifx\@empty\fromname % In case you don't use \name
          \else %
          \fromname\\
          \fi
          \fromaddress}
      \end{minipage}}}
  \put(15,95){\makebox(0,0)[tl]{\begin{minipage}[t][22mm][t]{80mm}
        \texttt{\Regarding}
      \end{minipage}}}
\end{picture}
\end{letter}
\clearpage}
