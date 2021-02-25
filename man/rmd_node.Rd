% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rmd_node.R
\name{rmd_node}
\alias{rmd_node}
\alias{rmd_node_label}
\alias{rmd_node_type}
\alias{rmd_node_length}
\alias{rmd_node_content}
\alias{rmd_node_attr}
\alias{rmd_node_engine}
\alias{rmd_node_options}
\alias{rmd_node_code}
\title{rmd node utility functions}
\usage{
rmd_node_label(x, ...)

rmd_node_type(x, ...)

rmd_node_length(x, ...)

rmd_node_content(x, ...)

rmd_node_attr(x, attr, ...)

rmd_node_engine(x, ...)

rmd_node_options(x, ...)

rmd_node_code(x, ...)
}
\arguments{
\item{x}{An rmd object, e.g. \code{rmd_ast} or \code{rmd_tibble}.}

\item{...}{Unused, for extensibility.}

\item{attr}{Attribute name to extract.}
}
\description{
\code{rmd_node_label()} - returns a node(s) labels.

\code{rmd_node_type()} - returns node(s) type / class.

\code{rmd_node_length()} - returns node(s) length (i.e. lines of code, lines of text, etc.)

\code{rmd_node_content()} - returns node(s) text content.

\code{rmd_node_attr()} - returns node(s) attribute value.

\code{rmd_node_engine()} - returns chunk(s) engine, \code{NA} for all other node types.

\code{rmd_node_options()} - returns chunk(s) options, \code{NA} for all other node types.

\code{rmd_node_code()} - returns chunk(s) code, \code{NA} for all other node types.
}