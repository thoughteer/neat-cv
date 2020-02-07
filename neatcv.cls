\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{neatcv}[2015/03/20 by Iskander Sitdikov]

\LoadClass[a4paper, 12pt]{article}

\RequirePackage[margin=0.618in]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T2A]{fontenc}
\RequirePackage[default]{droidserif}
\RequirePackage[russian, english]{babel}
\RequirePackage{csquotes}
\RequirePackage{etoolbox}
\RequirePackage{pbox}
\RequirePackage{calc}
\RequirePackage[table]{xcolor}
\RequirePackage{marvosym}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage[bottom, norule, flushmargin]{footmisc}
\RequirePackage[backend=biber, sorting=none, autolang=other]{biblatex}
\RequirePackage[hidelinks]{hyperref}

% Multiple language support.
\newcommand{\cvlanguage}[1]{%
    \expandafter\newcommand\csname cv#1\endcsname[1]{}%
}
\cvlanguage{english}
\cvlanguage{russian}
\newcommand{\cvsetlanguage}[1]{%
    \expandafter\renewcommand\csname cv\@cvlanguage\endcsname[1]{}%
    \expandafter\renewcommand\csname cv#1\endcsname[1]{##1}%
    \renewcommand{\@cvlanguage}{#1}%
}
\newcommand{\@cvlanguage}{english}
\cvsetlanguage{english}

% Name setter.
\newcommand{\@cvname}{}
\newcommand{\cvsetname}[1]{\renewcommand{\@cvname}{#1}}

% Major setter.
\newcommand{\@cvmajor}{}
\newcommand{\cvsetmajor}[1]{\renewcommand{\@cvmajor}{#1}}

% Postal address setter.
\newcommand{\@cvaddress}{}
\newcommand{\cvsetaddress}[1]{\renewcommand{\@cvaddress}{#1}}

% Phone number setter.
\newcommand{\@cvphone}{}
\newcommand{\cvsetphone}[1]{\renewcommand{\@cvphone}{#1}}

% E-mail setter.
\newcommand{\@cvemail}{}
\newcommand{\cvsetemail}[1]{\renewcommand{\@cvemail}{#1}}

% Homepage URL setter.
\newcommand{\@cvhomepage}{}
\newcommand{\cvsethomepage}[1]{\renewcommand{\@cvhomepage}{#1}}

% Colors.
\definecolor{cvbase}{HTML}{000000}
\definecolor{cvlow}{HTML}{666666}
\definecolor{cvhigh}{HTML}{772211}

% Color changing command.
% #1 - name of the color (base, low, or high).
\newcommand{\cvcolor}[1]{\leavevmode\color{cv#1}}

% Icons.
\newcommand{\cvaddressicon}{\Letter}
\newcommand{\cvphoneicon}{\Telefon}
\newcommand{\cvemailicon}{\MVAt}
\newcommand{\cvhomepageicon}{\Mundus}

% Lengths.
\newcommand{\cvnewlength}[2]{%
    \expandafter\newlength\csname @cv#1\endcsname%
    \expandafter\setlength\csname @cv#1\endcsname{#2}%
}
\cvnewlength{itempadding}{0.618em}
\cvnewlength{descriptionrulewidth}{0.09ex}
\cvnewlength{sectionruleheight}{1.618\@cvdescriptionrulewidth}
\cvnewlength{entrymargin}{8.5em}
\cvnewlength{itemmargin}{7em}
\cvnewlength{sectionskip}{1.618em}
\cvnewlength{entryskip}{1em}
\cvnewlength{paragraphskip}{0.618em}

% General formatting rules.
\pagenumbering{gobble}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}

% Skipping command.
% #1 - name of the skip (section, entry, or paragraph).
\newcommand{\cvskip}[1]{%
    \unskip%
    \setlength{\parskip}{\csname @cv#1skip\endcsname}%
    \par%
}

% Hyperlink printing command.
\newcommand{\cvurl}[2]{\href{#2}{#1}}

% E-mail printing command.
\newcommand{\cvemail}[1]{\cvurl{#1}{mailto:#1}}

% Generic description environment.
% #1 - vertical alignment (t [default], c or b).
% #2 - exact width of the key column.
% #3 - maximum width of the whole description.
\newenvironment{cvdescription*}[3][t]{%
    % Description item.
    % #1 - key.
    % #2 - value.
    \newcommand{\cvitem}[2]{%
        \cvcolor{low}\parbox[t]{#2}{\raggedleft##1\unskip\strut}&%
        \pbox[t]{\@cvitemwidth}{##2\unskip\strut}\\%
    }%
    \setlength{\arrayrulewidth}{\@cvdescriptionrulewidth}%
    \setlength{\tabcolsep}{\@cvitempadding}%
    \setlength{\extrarowheight}{0.618\@cvitempadding}%
    \setlength{\@cvitemwidth}{#3-#2-2\@cvitempadding-\@cvdescriptionrulewidth}%
    \arrayrulecolor{cvlow}%
    \begin{tabular}[#1]{@{}r|l@{}}%
}{\end{tabular}}
\newlength{\@cvitemwidth}

% Name printing command.
\newcommand{\cvname}{\pbox[t]{\textwidth}{\cvnamestyle\@cvname\unskip\strut}}
\newcommand{\cvnamestyle}{\Large\bfseries\scshape}
\newsavebox{\@cvnamebox}
\newlength{\@cvnamewidth}

% Major printing command.
\newcommand{\cvmajor}{\pbox[t]{\textwidth}{\cvmajorstyle\@cvmajor\unskip\strut}}
\newcommand{\cvmajorstyle}{\cvcolor{low}}
\newsavebox{\@cvmajorbox}
\newlength{\@cvmajorwidth}

% Introduction (name and major) printing command.
\newcommand{\cvintroduction}{%
    \savebox{\@cvnamebox}{\cvname}%
    \settowidth{\@cvnamewidth}{\usebox{\@cvnamebox}}%
    \savebox{\@cvmajorbox}{\cvmajor}%
    \settowidth{\@cvmajorwidth}{\usebox{\@cvmajorbox}}%
    \setlength{\@cvintroductionwidth}{\maxof{\@cvnamewidth}{\@cvmajorwidth}}
    \begin{minipage}[c]{\@cvintroductionwidth}%
        \cvskip{paragraph}\usebox{\@cvnamebox}%
        \ifdefempty{\@cvmajor}{}{\par\usebox{\@cvmajorbox}}%
    \end{minipage}
}
\newlength{\@cvintroductionwidth}

% Contact information printing command.
\newcommand{\cvcontacts}{%
    \settowidth{\@cviconwidth}{\cvemailicon}%
    \setlength{\@cvcontactswidth}{\textwidth-\@cvintroductionwidth}%
    \begin{cvdescription*}[c]{\@cviconwidth}{\@cvcontactswidth}%
        \cvitem{\cvaddressicon}{\@cvaddress}%
        \cvitem{\cvphoneicon}{\@cvphone}%
        \cvitem{\cvemailicon}{\cvemail{\@cvemail}}%
        \cvitem{\cvhomepageicon}{\cvurl{\@cvhomepage}{\@cvhomepage}}%
    \end{cvdescription*}%
}
\newlength{\@cviconwidth}
\newlength{\@cvcontactswidth}

% Header (introduction and contacts) printing command.
\newcommand{\cvheader}{\cvintroduction\hfill\cvcontacts}

% Section environment.
% #1 - title.
\newenvironment{cvsection}[1]{%
    % Section entry.
    % #1 - key.
    % #2 - value.
    \newcommand{\cventry}[2]{%
        \cvskip{entry}%
        \begin{minipage}[t]{\@cventrymargin}%
            \cvskip{paragraph}\cvcolor{high}\raggedleft##1%
        \end{minipage}%
        \hspace{\@cventryskip}%
        \begin{minipage}[t]{\@cvsectionwidth}%
            \cvskip{paragraph}\raggedright##2%
        \end{minipage}%
        \ignorespaces%
    }%
    \savebox{\@cvtitlebox}{\cvtitlestyle#1}%
    \settowidth{\@cvtitlewidth}{\usebox{\@cvtitlebox}}%
    \setlength{\@cvsectionwidth}{\textwidth-\@cventrymargin-\@cventryskip}%
    \cvskip{section}{%
        \cvcolor{high}%
        \cvsectionrule{\@cventrymargin}%
        \hspace{\@cventryskip}%
        \usebox{\@cvtitlebox}%
        \hspace{\@cventryskip}%
        \cvsectionrule{\@cvsectionwidth-\@cvtitlewidth-\@cventryskip}%
    }%
    \nopagebreak%
}{}
\newcommand{\cvtitlestyle}{\cvcolor{high}\footnotesize\bfseries\scshape}
\newcommand{\cvsectionrule}[1]{%
    \rule[0.5ex-0.5\@cvsectionruleheight]{#1}{\@cvsectionruleheight}%
}
\newsavebox{\@cvtitlebox}
\newlength{\@cvtitlewidth}
\newlength{\@cvsectionwidth}

% Description environment.
\newenvironment{cvdescription}[0]{%
    \footnotesize%
    \begin{cvdescription*}{\@cvitemmargin}{\textwidth}%
}{\end{cvdescription*}}

% List environment.
\newenvironment{cvlist}[0]{%
    % List item.
    % #1 - value.
    \newcommand{\cvitem}[1]{\item{##1}}%
    \begin{itemize}[---, nosep]%
}{\end{itemize}}

% Bibliography printing command.
\addbibresource{publications.bib}
\nocite{*}
\newcommand{\cvbibliography}{%
    \cvskip{entry}%
    \setlength{\@cvbibliographygap}{\partopsep+\topsep}%
    \vspace{-\@cvbibliographygap}%
    \setlength{\biblabelsep}{\@cventryskip}%
    \setlength{\bibhang}{0pt}%
    \setlength{\bibitemsep}{\@cventryskip}%
    \printbibliography[heading=none]%
}
\newlength{\@cvbibliographygap}

% Footnote text/mark printing command.
% #1 - text (omit to refer an existing footnote).
% #2 - mark name (unique for each footnote).
\newcommand{\cvfootnote}[2][]{%
    \ifstrempty{#1}{%
        \footnotemark[\csname @cvfootnote@#2\endcsname]%
    }{%
        \stepcounter{cvfootnotecounter}%
        \footnotetext[\thecvfootnotecounter]{#1}%
        \expandafter\newcommand\csname @cvfootnote@#2\endcsname{%
            \thecvfootnotecounter%
        }%
    }%
}
\newcounter{cvfootnotecounter}

% Command that prints the number of years passed since the given year.
% #1 - year to count from.
\newcommand{\cvyearssince}[1]{%
    {\advance\year by -#1 \the\year\advance\year by #1}%
}

% Reference printing command.
% #1 - name.
% #2 - e-mail.
% #3 - position.
\newcommand{\cvreference}[3]{%
    \cventry{\Writinghand}{%
        \textbf{#1\hfill\cvemail{#2}}%
        \par#3%
    }%
}
