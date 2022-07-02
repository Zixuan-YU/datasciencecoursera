### Lattice

-   plot in single function call  
-   Lattice plots tend to be most useful for **conditioning types of
    plots**, i.e. looking at how y changes with x across levels of z.

<!-- -->

    library(lattice)
    data(state)
    state <- data.frame(state.x77, region = state.region)
    xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))

![](EDA_week1_quiz_files/figure-markdown_strict/unnamed-chunk-1-1.png)

------------------------------------------------------------------------

#### Question 1

##### Which of the following is a principle of analytic graphics?

-   Show multivariate data

-   Make judicious use of color in your scatterplots (x)

-   Only do what your tools allow you to do

-   Don’t plot more than two variables at at time

-   Show box plots (univariate summaries)

------------------------------------------------------------------------

#### Question 3

##### Which of the following is true about the base plotting system?

-   Margins and spacings are adjusted automatically depending on the
    type of plot and the data

-   Plots are typically created with a single function call

-   The system is most useful for conditioning plots

-   **Plots are created and annotated with separate functions**

------------------------------------------------------------------------

#### Question 5

##### Which of the following is an example of a vector graphics device in R?

-   **SVG**  
-   TIFF
-   PNG  
-   GIF
-   JPEG

------------------------------------------------------------------------

#### Question 6

##### Bitmapped file formats can be most useful for

-   Plots that require animation or interactivity

-   **Scatterplots with many many points**

-   Plots that are not scaled to a specific resolution

-   Plots that may need to be resized

------------------------------------------------------------------------

#### Question 8

##### Which function opens the screen graphics device for the Mac?

-   bitmap()

-   png()

-   **quartz()**

-   pdf()

------------------------------------------------------------------------

#### Question 10

##### If I want to save a plot to a PDF file, which of the following is a correct way of doing that?

-   Open the screen device with quartz(), construct the plot, and then
    close the device with dev.off().

-   Construct the plot on the PNG device with png(), then copy it to a
    PDF with dev.copy2pdf().

-   Open the PostScript device with postscript(), construct the plot,
    then close the device with dev.off().

-   **Construct the plot on the screen device and then copy it to a PDF
    file with dev.copy2pdf()**
