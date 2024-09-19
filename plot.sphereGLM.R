

#' @export plot.sphere
plot.sphere <- function(df, X=NULL, col="red", cex=0.01, opacity=TRUE, add=FALSE, main=NULL, main.cex=2, main.position="topleft"){
  
  if(FALSE){
    df=Y; col=col1; opacity=opacity; add=add
    cex=0.01; axis.arrange=FALSE
    main <- "This is the main title"
    main.cex <- 2
  }
  
  library(rgl)
  
  if(FALSE){
    set.seed(1)
    plot.sphere(sim.sphereGLM(n=100)$Y, col="red", opacity=TRUE, main="This is the main title")
    plot.sphere(sim.sphereGLM(n=100)$Y, col="blue", opacity=TRUE, add=TRUE)
    
    set.seed(1)
    plot.sphere(sim.sphereGLM(n=100, mu=c(1,0,0), s=10)$Y, opacity=T)
    set.seed(1)
    plot.sphere(sim.sphereGLM(n=100, mu = c(0,1,0), s=10)$Y, col="blue", add=TRUE)
  }
  
  if(FALSE){
    df <- sim.sphereGLM(n=100, s=10)$X
    col="red"; cex=0.01; opacity=TRUE; add=FALSE
  }
  
  
  
  
  
  if( ncol(df) != 3 ) stop("Check the number of columns")
  
  
  if(!is.null(X)){
    
    col1 <- "red"
    col2 <- "blue"
    col3 <- "purple"
    
    value_to_color <- function(value, min_val, max_val) {
      scaled <- (value - min_val) / (max_val - min_val)
      r <- 1 - scaled
      g <- 0
      b <- scaled
      rgb(r, g, b)
    }
    # blue: high; red: low
    
    col <- value_to_color(X, min(X), max(X))
    
  }
  
  
  
  
  # if(axis.arrange){
  #   x <- df[,1]
  #   y <- df[,3]
  #   z <- df[,2]
  # } else {
  x <- df[,1]
  y <- df[,2]
  z <- df[,3]
  # }
  
  
  if(!add){
    
    open3d()
    # getr3dDefaults()
    # rgl.par3d.names
    # par3d()$viewport
    par3d(userMatrix = rotationMatrix(45*pi/180, 1, 0, 0),
          # userProjection = matrix(c(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1),4,4,byrow=T),
          # windowRect=c(0,45,800,800)
          windowRect=c(0,45,500,500)
    )
    
    # if(!is.null(main) | !is.null(submain)){
    #   
    #   bgplot3d({
    #     plot.new()
    #     if(!is.null(main)) title(main = main, line = 3)
    #     if(!is.null(submain)) mtext(side = 1, submain, line = 4)
    #     # use here any other way you fancy to write your title
    #   }, magnify = 0.5)
    #   
    # }
    
    if(opacity){
      spheres3d(0,0,0,lit=FALSE,color="white")
      spheres3d(0,0,0,radius=1.0,lit=FALSE,color="black",front="lines")
    } else {
      plot.sphere.grid(add=TRUE)
    }
    
    
  }
  
  
  if(!is.null(main)) legend3d(main.position, legend = main, adj=0.1, cex=main.cex, bty="n", border = FALSE)
  
  # legend3d("topright", legend = paste('Type', c('A', 'B', 'C')), pch = 16, col = rainbow(3), cex=1, inset=c(0.02))
  
  
  spheres3d(x,y,z,col=col,radius=cex)
  
  rgl::text3d(1.1,0,0, texts="(1,0,0)")
  rgl::text3d(0,1.1,0, texts="(0,1,0)")
  rgl::text3d(0,0,1.1, texts="(0,0,1)")
  
  rgl::text3d(-1.1,0,0, texts="(-1,0,0)")
  rgl::text3d(0,-1.1,0, texts="(0,-1,0)")
  rgl::text3d(0,0,-1.1, texts="(0,0,-1)")
  
  
}














#' @export plot.sphere.grid
plot.sphere.grid <- function (radius = 1, col.long = "red", col.lat = "blue", deggap = 15, longtype = "H", add = FALSE, radaxis = TRUE, radlab = "Radius"){
  if(FALSE){
    radius = 1; col.long = "red"; col.lat = "blue"; deggap = 15;
    longtype = "H"; add = FALSE; radaxis = TRUE; radlab = "Radius"
  }
  
  
  # if(FALSE){
  #   library(sphereplot)
  #   sphereplot::pointsphere()
  #   
  #   rgl.sphgrid()
  #   rgl.sphpoints(pointsphere(100,c(0,90),c(0,45),c(0.25,0.8)),deg=T)
  #   
  #   rgl.sphgrid(radaxis=F, radlab=F)
  #   rgl.sphpoints(40,50,0.5,deg=TRUE,col='red',cex=2)
  # }
  
  
  
  if (add == F) {
    open3d()
    
    par3d(userMatrix = rotationMatrix(-15*pi/180, 1, 0, 0),
          # userProjection = matrix(c(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1),4,4,byrow=T),
          # windowRect=c(0,45,800,800)
          windowRect=c(0,45,800,800)
    )
    
  }
  for (lat in seq(-90, 90, by = deggap)) {
    if (lat == 0) {
      col.grid = "grey50"
    }
    else {
      col.grid = "grey"
    }
    plot3d(png.sph2coord(long = seq(0, 360, len = 100), lat = lat,
                         radius = radius, deg = T), col = col.grid, add = T,
           type = "l")
  }
  for (long in seq(0, 360 - deggap, by = deggap)) {
    if (long == 0) {
      col.grid = "grey50"
    }
    else {
      col.grid = "grey"
    }
    plot3d(png.sph2coord(long = long, lat = seq(-90, 90, len = 100),
                         radius = radius, deg = T), col = col.grid, add = T,
           type = "l")
  }
  if (longtype == "H") {
    scale = 15
  }
  if (longtype == "D") {
    scale = 1
  }
  # rgl.sphtext(long = 0, lat = seq(-90, 90, by = deggap), radius = radius,
  #             text = seq(-90, 90, by = deggap), deg = TRUE, col = col.lat)
  # rgl.sphtext(long = seq(0, 360 - deggap, by = deggap), lat = 0,
  #             radius = radius, text = seq(0, 360 - deggap, by = deggap)/scale,
  #             deg = TRUE, col = col.long)
  # if (radaxis) {
  #   radpretty = pretty(c(0, radius))
  #   radpretty = radpretty[radpretty <= radius]
  #   lines3d(c(0, 0), c(0, max(radpretty)), c(0, 0), col = "grey50")
  #   for (i in 1:length(radpretty)) {
  #     lines3d(c(0, 0), c(radpretty[i], radpretty[i]),
  #             c(0, 0, radius/50), col = "grey50")
  #     text3d(0, radpretty[i], radius/15, radpretty[i],
  #            col = "darkgreen")
  #   }
  #   text3d(0, radius/2, -radius/25, radlab)
  # }
  
}



png.coord2sph <- function(x,y,z){
  R=1
  lat = asin(z / R)
  long = atan2(y, x)
  cbind.data.frame(long=long, lat=lat)
}





png.sph2coord <- function (long, lat, radius = 1, deg = TRUE){
  # if(FALSE){
  #   x = R * cos(lat) * cos(long)
  #   y = R * cos(lat) * sin(long)
  #   z = R * sin(lat)
  #   cbind.data.frame(x=x,y=y,z=z)
  # }
  
  
  if (is.matrix(long) || is.data.frame(long)) {
    if (ncol(long) == 1) {
      long = long[, 1]
    }
    else if (ncol(long) == 2) {
      lat = long[, 2]
      long = long[, 1]
    }
    else if (ncol(long) == 3) {
      radius = long[, 3]
      lat = long[, 2]
      long = long[, 1]
    }
  }
  if (missing(long) | missing(lat)) {
    stop("Missing full spherical 3D input data.")
  }
  if (deg) {
    long = long * pi/180
    lat = lat * pi/180
  }
  return = cbind(x = radius*cos(lat)*cos(long),
                 y = radius*cos(lat)*sin(long),
                 z = radius*sin(lat))
}








