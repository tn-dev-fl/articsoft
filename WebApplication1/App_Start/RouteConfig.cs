using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace WebApplication1
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);

            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
              name: "Admin",
              url: "admin/api/login",  // URL pattern to match
              defaults: new { controller = "Admin", action = "Index" } // Route to AdminController/Index action
                );
            routes.MapRoute(
                name: "GetItems",
                url: "admin/api/items",  // Custom URL for GetItems
                defaults: new { controller = "Admin", action = "GetItems" }
                    );
            routes.MapRoute(
                name: "Dashboard",
                url: "admin/api/Dashboard",  // Custom URL for GetItems
                defaults: new { controller = "Admin", action = "Dashboard" }
                    );

            routes.MapRoute(
               name: "itemsearch",
               url: "admin/api/items",  // Custom URL for GetItems
               defaults: new { controller = "Admin", action = "GetItemsBySearch" }
                   );
            routes.MapRoute(
               name: "submit",
               url: "admin/api/submit",  // Custom URL for GetItems
               defaults: new { controller = "Admin", action = "SubmitOrder" }
                   );
            routes.MapRoute(
                    name: "Default",
                    url: "{controller}/{action}/{id}",
                    defaults: new { action = "Index", id = UrlParameter.Optional }
                );  
        }
    }
}
