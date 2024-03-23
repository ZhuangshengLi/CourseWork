book.total_volumes <- function(book) {
  # Arguments:
  #   book - A list containing "ask" and "bid", each of which are dataframes
  #       containing the collection of limit orders.
  #
  # Returns:
  #   The total volume in the book.
  
  total_volumes=list(bid=sum(book$bid$size), ask=sum(book$ask$size))
  return(total_volumes)
  
}

book.best_prices <- function(book) {
  # Arguments:
  #   book - A list containing "ask" and "bid", each of which are dataframes
  #       containing the collection of limit orders.
  #
  # Returns:
  #   A list with "ask" and "bid", the values of which are the best prices in
  #       the book.
  
  best_prices = list(bid = max(book$bid[ ,2]),ask = min(book$ask[ ,2])) 
  return(best_prices)
}

book.midprice <- function(book) {
  # Arguments:
  #   book - A list containing "ask" and "bid", each of which are dataframes
  #       containing the collection of limit orders.
  #
  # Returns:
  #   The midprice of the book.
  list = book.best_prices(book)
  return((list$ask + list$bid) / 2)
}

book.spread <- function(book) {
  # Arguments:
  #   book - A list containing "ask" and "bid", each of which are dataframes
  #       containing the collection of limit orders.
  #
  # Returns:
  #   The spread of the book.
  list = book.best_prices(book)
  return(abs(list$ask-list$bid))
}

book.add <- function(book, message) {
  # Arguments:
  #   book - A list containing "ask" and "bid", each of which are dataframes
  #       containing the collection of limit orders.
  #   message - A list containing "oid", "side", "price" and "size" entries.
  #
  # Returns:
  #   The updated book.
  
  if (message$side == 'S') {
    if (nrow(book$bid) != 0 && book.best_prices(book)$bid >= message$price) {
      remain = message$size
      
      while (remain > 0 && book.best_prices(book)$bid >= message$price) {
        min = min(remain, book$bid[,3][1])
        
        if (min == book$bid[,3][1]){
          book$bid = book$bid[-1,] 
        }else {
          book$bid[,3][1] = book$bid[,3][1] - min
        }
        remain = remain - min
      }
      
      if (remain > 0) {
        ele = data.frame(oid=message$oid, price=message$price, size=remain, stringsAsFactors=FALSE)
        book$ask = rbind(book$ask, ele)
      }
    }
    else {
      ele = data.frame(oid=message$oid, price=message$price, size=message$size, stringsAsFactors=FALSE) 
      book$ask = rbind(book$ask, ele)
    }
  } 
  else {
    if (nrow(book$ask) != 0 && book.best_prices(book)$ask <= message$price){
      remain = message$size
      
      while (remain > 0 && book.best_prices(book)$ask <= message$price){
        min = min(remain, book$ask[,3][1])
        
        if (min == book$ask[,3][1]){
          book$ask = book$ask[-1,] 
        }else {
          book$ask[,3][1] = book$ask[,3][1] - min
        }
        remain = remain - min
      }
      
      if (remain > 0) {
        ele = data.frame(oid=message$oid, price=message$price, size=remain, stringsAsFactors=FALSE)
        book$bid = rbind(book$bid, ele)
      }
    }
    else {
      ele = data.frame(oid=message$oid, price=message$price, size=message$size, stringsAsFactors=FALSE) 
      book$bid = rbind(book$bid, ele)
    }
  }
  book = book.sort(book)
  
  return(book)
}

book.reduce <- function(book, message) {
  # Arguments:
  #   book - A list containing "ask" and "bid", each of which are dataframes
  #       containing the collection of limit orders.
  #   message - A list containing "oid" and "amount".
  #
  # Returns:
  #   The updated book.
  id = which(book[['ask']]$oid == message$oid)
  
  for(i in id){
    book[['ask']]$size[i] = book[['ask']]$size[i] - message$amount
    
    if(book[['ask']]$size[i] <= 0){
      book[['ask']] = book[['ask']][-i, ]
    }
  }
  
  id = which(book[['bid']]$oid == message$oid)
  
  for(i in id){
    book[['bid']]$size[i] = book[['bid']]$size[i] - message$amount
    
    if(book[['bid']]$size[i] <= 0){
      book[['bid']] = book[['bid']][-i, ]
    }
  }
  
  
  return(book)
}

###############################################################################
###############################################################################

# The following functions are the "extra" functions; marks for these functions
# are only available if you have fully correct implementations for the 6
# functions above

book.extra1 <- function(book, size) {
  # See handout for instructions
  if(dim(book$ask)[1] == 0 || size >= book.total_volumes(book)$ask){
    return(NA)
  }
  
  count = 0
  sum = 0
  
  for(price in book$ask$price){
    temp = book
    message = list(
      oid='E1',
      side='B',
      price=as.numeric(price),
      size=as.numeric(size)
    )
    temp = book.add(temp, message)
    temp_midprice = book.midprice(temp)
    
    if(!is.na(temp_midprice)){
      sum = sum + temp_midprice
      count = count + 1
    }
  }
  
  return(sum/count)
  
}

book.extra2 <- function(book, size) {
  # See handout for instructions
  
  if(nrow(book$ask) == 0 || size == book.total_volumes(book)$ask){
    return(NA)
  }
  
  best_price = min(book$ask$price)
  highest_price = max(book$ask$price)
  count = 0
  sum = 0
  
  for(price in seq(ceiling(best_price), floor(highest_price))){
    temp = book
    message = list(
      oid='E2',
      side='B',
      price=as.numeric(price),
      size=as.numeric(size)
    )
    temp = book.add(temp, message)
    
    if(!is.na(book.midprice(temp))){
      sum = sum + book.midprice(temp)
      count = count + 1
    }
  }
  
  return(sum / (highest_price - best_price + 1))
}

book.extra3 <- function(book) {
    if(nrow(book$ask) == 0){
      return(NA)
    }
  
  sum = 0
  count = book.total_volumes(book)$ask - 1
  num = count
  
  while(count > 0){
    temp = book
    message = list(
      oid='E4',
      side='B',
      price=as.numeric(max(temp$ask$price)),
      size=as.numeric(count)
    )
    
    temp = book.add(temp, message)
    sum = sum + book.midprice(temp)
    count = count - 1
  }
  
   return(sum / num)
  
}


book.extra4 <- function(book, k) {
  if (nrow(book$ask) == 0) {
    return(NA)
  }
  # See handout for instructions
  count = 0
  temp = book
  ori_midprice = book.midprice(book)
  limit = ori_midprice * (1 + k/100)
  
  for(i in nrow(book$ask)){
    count = count + temp$ask$size[1]
    message = list(
      oid='E4',
      side='B',
      price=as.numeric(temp$ask$price[1]),
      size=as.numeric(temp$ask$size[1])
    )  
    
    book.add(temp, message)
    
    if(nrow(temp$ask) == 0 || book.midprice(temp) >= limit){
      break
    }
  }
  
  return(count-1)
}
