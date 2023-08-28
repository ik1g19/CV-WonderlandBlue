\ProvidesClass{twentysecondcv}[2017/01/08 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

%----------------------------------------------------------------------------------------
%	 REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage[sfdefault]{ClearSans}
\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{parskip}

\usepackage{titlesec}
\usepackage{pgffor}
\usepackage{xparse}
\usepackage{tabularx}
\usepackage{xstring}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%----------------------------------------------------------------------------------------
%	 COLOURS
%----------------------------------------------------------------------------------------

\definecolor{white}{RGB}{255,255,255}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{sidecolor}{HTML}{272828}
\definecolor{mainblue}{HTML}{0E5484}
\definecolor{maingray}{HTML}{B9B9B9}
\definecolor{webblue}{HTML}{5ce1e6} % 5ce1e6 in RGB
\definecolor{sectionblue}{HTML}{38b6ff}
\definecolor{body}{HTML}{D3D3D3} % You can change the color code as needed.
\definecolor{tagblue}{HTML}{38b6ff}


%----------------------------------------------------------------------------------------
%	 MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------

%\renewcommand{\bfseries}{\color{gray}} % Make \textbf produce coloured text instead

\pagestyle{empty} % Disable headers and footers

\setlength{\parindent}{0pt} % Disable paragraph indentation

%----------------------------------------------------------------------------------------
%	 SIDEBAR DEFINITIONS
%----------------------------------------------------------------------------------------

\setlength{\TPHorizModule}{1cm} % Left margin
\setlength{\TPVertModule}{1cm} % Top margin

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

% Define the color 38b6ff
\definecolor{mysectioncolor}{HTML}{38b6ff}

\newlength{\TotalSectionLength} % Define a new length to hold the remaining line width after the section title is printed
\newlength{\SectionTitleLength} % Define a new length to hold the width of the section title
\newcommand{\profilesection}[1]{%
    \vspace{8pt}% Whitespace before the section title
    {\color{mysectioncolor} \huge \MakeUppercase{#1}}\\% Print the title in all caps and the defined color
    {\color{white} \rule[0.15\baselineskip]{\linewidth}{1pt}}% Print the rule in white beneath the title
    \vspace{-1.5em}% Whitespace after the rule
}




% Define custom commands for CV info
\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
\newcommand{\education}[1]{\renewcommand{\education}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}



% Define the storage macro
\newcommand{\modulelist}{} 
% Define the setter macro
\newcommand{\setmodulelist}[1]{\renewcommand{\modulelist}{#1}}
\newcounter{modulecounter}

\newcommand{\accumulatemodules}[1]{
    \stepcounter{modulecounter}
    \ifodd\value{modulecounter}
        \xdef\modulecontent{\modulecontent #1 &}
    \else
        \xdef\modulecontent{\modulecontent #1 \\}
    \fi
}

% Define a new column type Y that does not hyphenate its content
\newcolumntype{Y}{>{\raggedright\arraybackslash}X}


\NewDocumentCommand{\qualifications}{}{
    \setcounter{modulecounter}{0}
    \def\modulecontent{} 
    \foreach \x in \modulelist {
        \accumulatemodules{\x}
    }
    \begin{tabularx}{\linewidth}{YY}
    \modulecontent 
    \end{tabularx}
}



%% Define the storage macro
%\newcommand{\skilllist}{}
%% Define the setter macro
%\newcommand{\setskilllist}[1]{\renewcommand{\skilllist}{#1}}
%
%\newcommand{\accumulateskills}[1]{
%    \xdef\skillcontent{\skillcontent \colorbox{sectionblue}{#1orange} }
%}
%
%\NewDocumentCommand{\skills}{}{
%    \def\skillcontent{} 
%    \foreach \x in \skilllist {
%        \accumulateskills{\x}
%    }
%    \skillcontent
%}


% Define the storage macro
\newcommand{\taglist}{} 
% Define the setter macro
\newcommand{\setcvtags}[1]{\renewcommand{\taglist}{#1}}

% Fork v1.6.5c: A parser for several tags that will reutilize the cvtag component in a less verbose way
\newcommand{\cvtags}{%
	\foreach \tagValue in \taglist {%
		\cvtag{\tagValue}
	}
}

% Fork (before v1.6.5a): Tags now have a more consistent vertican and horizontal separation
\newcommand{\cvtag}[1]{%
	\color{white}
	\tikz[baseline]\node[anchor=base,fill=black,draw=black,rounded corners,inner xsep=1ex,inner ysep=0.75ex,text height=1.5ex,text depth=.25ex]{\bfseries#1};
	\vspace{0.25ex}
}









% Command for printing the contact information icons
\newcommand*\icon[1]{\tikz[baseline=(char.base)]{\node[shape=circle,draw,inner sep=1pt, fill=mainblue,mainblue,text=white] (char) {#1};}}



%----------------------------------------------------------------------------------------
%	 SIDEBAR LAYOUT
%----------------------------------------------------------------------------------------

\newcommand{\makeprofile}{
	\begin{tikzpicture}[remember picture,overlay]
   		\node [rectangle, fill=sidecolor, anchor=north, minimum width=9cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};
	\end{tikzpicture}
 

	%------------------------------------------------

	\begin{textblock}{6}(0.5, 0.2)
			
		%------------------------------------------------
		
		% \ifthenelse{\equal{\profilepic}{}}{}{
		% 	\begin{center}
		% 		\begin{tikzpicture}[x=\imagescale,y=-\imagescale]
		% 			\clip (600/2, 567/2) circle (567/2);
		% 			\node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\profilepic}};
		% 		\end{tikzpicture}
		% 	\end{center}
		% }

		%------------------------------------------------

		{\Huge\color{white}\cvname}

		%------------------------------------------------

		%------------------------------------------------

		\renewcommand{\arraystretch}{1.6}
        \begin{tabular}{p{0.5cm} @{\hskip 0.5cm}p{5cm}}
            \ifthenelse{\equal{\cvaddress}{}}{}{\Large\includegraphics[height=1em]{map.png} & \raisebox{0.35em}{\color{white}\texttt{\cvaddress}}\\} % Modified line
            \ifthenelse{\equal{\cvnumberphone}{}}{}{\Large\includegraphics[height=1em]{phone-receiver-silhouette.png} & \raisebox{0.35em}{\color{white}\texttt{\cvnumberphone}}\\} % Modified line
            \ifthenelse{\equal{\cvsite}{}}{}{\Large\includegraphics[height=1em]{world-wide-web.png} & \raisebox{0.35em}{\color{white}\texttt{\cvsite}}\\} % Modified line
            \ifthenelse{\equal{\cvmail}{}}{}{\Large\includegraphics[height=1em]{mail.png} & \raisebox{0.35em}{\color{white}\texttt{\cvmail}}\\} % Modified line
        \end{tabular}



		%------------------------------------------------
		
%		\ifthenelse{\equal{\skills}{}}{}{
%			\profilesection{Key Skills}
%            \color{white}    
%			\begin{flushleft}
%				\skills
%			\end{flushleft}
%		}
		{
			\profilesection{Education}
			\color{white}
			\begin{flushleft}
				\vspace{-1.4em}
				\begin{tabular}{l} % Environment for a list with descriptions
					\myEducationTable
				\end{tabular}
		
			\end{flushleft}
		}

		%------------------------------------------------

        {
			\profilesection{Qualifications}   
			\color{white}
			\begin{flushleft}
				{\large\textbf{MEng Computer Science 2:1}}
				\qualifications
				\schoolgrades
			\end{flushleft}
		}

			
		%------------------------------------------------
			
	\end{textblock}
}




\newcommand{\sidebartwo}{
	\begin{tikzpicture}[remember picture,overlay]
   		\node [rectangle, fill=sidecolor, anchor=north, minimum width=9cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};
	\end{tikzpicture}
 

    %------------------------------------------------

	\begin{textblock}{6}(0.5, 0.2)
			
		%------------------------------------------------
		
		% \ifthenelse{\equal{\profilepic}{}}{}{
		% 	\begin{center}
		% 		\begin{tikzpicture}[x=\imagescale,y=-\imagescale]
		% 			\clip (600/2, 567/2) circle (567/2);
		% 			\node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\profilepic}};
		% 		\end{tikzpicture}
		% 	\end{center}
		% }



			
		%------------------------------------------------
			
	\end{textblock}	
}

%----------------------------------------------------------------------------------------
%	 COLOURED SECTION TITLE BOX
%----------------------------------------------------------------------------------------

% Command to create the rounded boxes around the first three letters of section titles


\titleformat*{\section}{\Large\bfseries\color{black}}

\renewcommand{\subsection}[1]{
	\par\vspace{.5\parskip}{%
		\large\color{gray} #1%
	}
	\par\vspace{.25\parskip}%
}

%----------------------------------------------------------------------------------------
%	 LONG LIST ENVIRONMENT
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

% New environment for the long list
\newenvironment{twenty}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
	\end{tabular*}
}

\newenvironment{projects}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}l}
	}{%
	\end{tabular*}
}

\newcommand{\twentyitem}[4]{%
	#1&\parbox[t]{0.83\textwidth}{%
		\textbf{#2}%
		\hfill%
		{\footnotesize#3}\\%
		#4\vspace{\parsep}%
	}\\
}



\newcommand{\projectitem}[3]{%
	\parbox[t]{\linewidth}{%
		\textbf{#1}
		\hfill
		{\footnotesize#2}\\
		#3\vspace{1.0em}
	}\\
}



\newcommand{\educationitem}[3]{%
	\parbox[t]{\textwidth}{%
		#1\\
		\textbf{#2}\\
		#3
	}\vspace{0.3em}\\
}




%----------------------------------------------------------------------------------------
%	 SMALL LIST ENVIRONMENT
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

% New environment for the small list
\newenvironment{twentyshort}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
	\end{tabular*}
}

\newcommand{\twentyitemshort}[2]{%
	#1&\parbox[t]{0.83\textwidth}{%
		\textbf{#2}%
	}\\
}

%----------------------------------------------------------------------------------------
%	 MARGINS AND LINKS
%----------------------------------------------------------------------------------------

\RequirePackage[left=7.6cm,top=0.1cm,right=1cm,bottom=0.2cm,nohead,nofoot]{geometry}

\RequirePackage{hyperref}
