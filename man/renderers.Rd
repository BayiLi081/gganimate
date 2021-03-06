% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/renderers.R
\name{renderers}
\alias{renderers}
\alias{gifski_renderer}
\alias{file_renderer}
\alias{av_renderer}
\alias{ffmpeg_renderer}
\alias{magick_renderer}
\alias{sprite_renderer}
\title{Renderers provided by gganimate}
\usage{
gifski_renderer(file = tempfile(fileext = ".gif"), loop = TRUE,
  width = NULL, height = NULL)

file_renderer(dir = ".", prefix = "gganim_plot", overwrite = FALSE)

av_renderer(file = NULL, vfilter = "null", codec = NULL,
  audio = NULL)

ffmpeg_renderer(format = "auto", ffmpeg = NULL,
  options = list(pix_fmt = "yuv420p"))

magick_renderer(loop = TRUE)

sprite_renderer()
}
\arguments{
\item{file}{The animation file}

\item{loop}{Logical. Should the produced gif loop}

\item{width, height}{Dimensions of the animation in pixels. If \code{NULL} will
take the dimensions from the frame, otherwise it will rescale it.}

\item{dir}{The directory to copy the frames to}

\item{prefix}{The filename prefix to use for the image files}

\item{overwrite}{Logical. If TRUE, existing files will be overwritten.}

\item{vfilter}{A string defining an ffmpeg filter graph. This is the same
parameter as the \code{-vf} argument in the \code{ffmpeg} command line utility.}

\item{codec}{The name of the video codec. The default is \code{libx264} for most
formats, which usually the best choice. See the \code{av} documentation for more
information.}

\item{audio}{An optional file with sounds to add to the video}

\item{format}{The video format to encode the animation into}

\item{ffmpeg}{The location of the \code{ffmpeg} executable. If \code{NULL} it will be
assumed to be on the search path}

\item{options}{Either a character vector of command line options for ffmpeg
or a named list of option-value pairs that will be converted to command line
options automatically}

\item{...}{arguments passed on to the selected renderer}
}
\value{
The provided renderers are factory functions that returns a new function
that take \code{frames} and \code{fps} as arguments, the former being a character
vector with file paths to the images holding the separate frames, in the
order they should appear, and the latter being the framerate to use for the
animation in frames-per-second.

The return type of the different returned renderers are:
\itemize{
\item \strong{\code{gifski_renderer}}: Returns a \link{gif_image} object
\item \strong{\code{magick_renderer}}: Returns a \code{magick-image} object
\item \strong{\code{av_renderer}}: Returns a \link{video_file} object
\item \strong{\code{ffmpeg_renderer}}: Returns a \link{video_file} object
\item \strong{\code{file_renderer}}: Returns a vector of file paths
}
}
\description{
The purpose of the renderer function is to take a list of image files and
assemble them into an animation. \code{gganimate} provide a range of renderers
but it is also possible to provide your own, if the supplied ones are lacking
in any way. A renderer is given as argument to \code{\link[=animate]{animate()}}/print() and
receives the paths to the individual frames once they have been created.
}
\details{
The \code{gifski_renderer()} is used unless otherwise specified in
\code{\link[=animate]{animate()}} or in \code{options('gganimate.renderer')}. This renderer requires
both the \code{gifski} and \code{png} packages to be installed.

Other possible renderers are:
\itemize{
\item \code{magick_renderer()} which requires the \code{magick} package and produce a \code{gif}.
If \code{gifski} is not installed, the rendering will be much slower than using the
\code{gifski_renderer()} and can potentially result in system problems when many
frames need to be rendered (if \code{gifski} is installed \code{magick} will use it
under the hood)
\item \code{av_renderer()} which requies the \code{av} package and uses ffmpeg to encode
the animation into a video file.
\item \code{ffmpeg_renderer()} which requires that ffmpeg has been installed on your
computer. As with \code{av_renderer()} it will use ffmpeg to encode the animation
into a video
\item \code{sprite_renderer()} which requires \code{magick} and will render the animation
into a spritesheet
\item \code{file_renderer()} which has no dependencies and simply returns the
animation as a list of image files (one for each frame)
}

It is possible to create your own renderer function providing that it
matches the required signature (\code{frames} and \code{fps} argument). The return
value of your provided function will be the return value ultimately given by
\code{\link[=animate]{animate()}}
}
\examples{
anim <- ggplot(mtcars, aes(mpg, disp)) +
  transition_states(gear, transition_length = 2, state_length = 1) +
  enter_fade() +
  exit_fade()

\dontrun{
# Renderers are specified in the `animate()` function
animate(anim, renderer = sprite_renderer())
}

}
