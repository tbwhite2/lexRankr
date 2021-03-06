% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bind_lexrank.R
\name{bind_lexrank_}
\alias{bind_lexrank_}
\alias{bind_lexrank}
\title{Bind lexrank scores to a dataframe of text}
\usage{
bind_lexrank_(tbl, text, doc_id, sent_id = NULL, level = c("sentences",
  "tokens"), threshold = 0.2, usePageRank = TRUE, damping = 0.85,
  continuous = FALSE, ...)

bind_lexrank(tbl, text, doc_id, sent_id = NULL, level = c("sentences",
  "tokens"), threshold = 0.2, usePageRank = TRUE, damping = 0.85,
  continuous = FALSE, ...)
}
\arguments{
\item{tbl}{dataframe containing column of sentences to be lexranked}

\item{text}{name of column containing sentences or tokens to be lexranked}

\item{doc_id}{name of column containing document ids corresponding to \code{text}}

\item{sent_id}{Only needed if \code{level} is "tokens". name of column containing sentence ids corresponding to \code{text}}

\item{level}{the parsed level of the text column to be lexranked.  i.e. is \code{text} a column of "sentences" or "tokens"?  The "tokens" level is provided to allow users to implement custom tokenization.  Note: even if the input \code{level} is "tokens" lexrank scores are assigned at the sentence level.}

\item{threshold}{The minimum simililarity value a sentence pair must have to be represented in the graph where lexRank is calculated.}

\item{usePageRank}{\code{TRUE} or \code{FALSE} indicating whether or not to use the page rank algorithm for ranking sentences.  If \code{FALSE}, a sentences unweighted centrality will be used as the rank.  Defaults to \code{TRUE}.}

\item{damping}{The damping factor to be passed to page rank algorithm.  Ignored if \code{usePageRank} is \code{FALSE}.}

\item{continuous}{\code{TRUE} or \code{FALSE} indicating whether or not to use continuous LexRank.  Only applies if \code{usePageRank==TRUE}.  If \code{TRUE}, \code{threshold} will be ignored and lexRank will be computed using a weighted graph representation of the sentences. Defaults to \code{FALSE}.}

\item{...}{tokenizing options to be passed to lexRankr::tokenize.  Ignored if \code{level} is "sentences"}
}
\value{
A dataframe with an additional column of lexrank scores (column is given name lexrank)
}
\description{
Bind lexrank scores to a dataframe of sentences or to a dataframe of tokens with sentence ids
}
\examples{
library(dplyr)

df <- dplyr::tibble(doc_id = 1:3, 
                    text = c("Testing the system. Second sentence for you.", 
                             "System testing the tidy documents df.", 
                             "Documents will be parsed and lexranked."))

df \%>\% 
  unnest_sentences(sents, text) \%>\% 
  bind_lexrank(sents, doc_id, level = 'sentences')

df \%>\% 
  unnest_sentences(sents, text) \%>\% 
  bind_lexrank_("sents", "doc_id", level = 'sentences')

df <- data.frame(doc_id  = c(1, 1, 1, 1, 1, 1, 1, 2, 2, 2,
                             2, 2, 2, 3, 3, 3, 3, 3, 3), 
                 sent_id = c(1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 
                             1, 1, 1, 1, 1, 1, 1, 1, 1), 
                 tokens = c("testing", "the", "system", "second", 
                            "sentence", "for", "you", "system", 
                            "testing", "the", "tidy", "documents", 
                            "df", "documents", "will", "be", "parsed", 
                            "and", "lexranked"),
                 stringsAsFactors = FALSE)

df \%>\% 
  bind_lexrank(tokens, doc_id, sent_id, level = 'tokens')
}
