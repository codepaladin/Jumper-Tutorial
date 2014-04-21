if ( string.sub( system.getInfo("model"), 1, 4 ) == "iPad" ) then
   application =
   {
      content =
      {
         width = 768,
         height = 1024,
         scale = "letterBox",
         xAlign = "center",
         yAlign = "center",
         imageSuffix =
         {
            ["@2x"] = 1.5,
            ["@4x"] = 3.0,
         },
      },
   }
end