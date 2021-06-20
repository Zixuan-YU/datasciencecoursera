makeCacheMatrix <- function(x = matrix()) {
    I <- NULL # I = Inverse Matrix
    set <- function(y) {
        x <<- y 
        I <<- NULL
  }
    get <- function() x
    setInverse <- function(inverse) I <<- inverse
    getInverse <- function() I
    list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}

cacheSolve <- function(x, ...){
      I <- x$getInverse()
      if (!is.null(I)){
            message("Getting cached data")
            return(I)
      }else{ #if the Inverse hasn't been computed yet
      m <- x$get()
      I <- solve(m, ...)
      x$setInverse(I)
      I
      }
}
