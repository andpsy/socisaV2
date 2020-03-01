using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace socisaWeb
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "DosareDashboardAdminAndSuper",
                url: "Dashboard/GetDosareDashboardAdminAndSuper/{_type}",
                defaults: new
                {
                    controller = "Dashboard",
                    action = "GetDosareDashboardAdminAndSuper",
                    _type = UrlParameter.Optional
                }
            );
            /*
            routes.MapRoute(
                name: "TestEShow",
                url: "Test/eShow/{token}",
                defaults: new
                {
                    controller = "Test",
                    action = "eShow"
                }
            );
            */
            routes.MapRoute(
                name: "DosareEShow",
                url: "EShow/{token}",

                defaults: new
                {
                    controller = "Dosare",
                    action = "EShow"
                }
            );
            
            routes.MapRoute(
                name: "TokenLogin",
                url: "TokenLogin/{_url}/{_token}",

                defaults: new
                {
                    controller = "Utilizatori",
                    action = "TokenLogin"
                }
            );

            routes.MapRoute(
                name: "DashboardEShow",
                url: "Dashboard/IndexMain/{id}",

                defaults: new
                {
                    controller = "Dashboard",
                    action = "IndexMain"
                }
            );

            routes.MapRoute(
                name: "DosareEPrint",
                url: "EPrint/{token}",

                defaults: new
                {
                    controller = "Dosare",
                    action = "EPrint"
                }
            );

            routes.MapRoute(
                name: "DosareEZip",
                url: "EZip/{token}",

                defaults: new
                {
                    controller = "Dosare",
                    action = "EZip"
                }
            );

            routes.MapRoute(
                name: "DosareEZipBulk",
                url: "EZipBulk/{token}",

                defaults: new
                {
                    controller = "Dosare",
                    action = "EZipBulk"
                }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "NotificariEmailFilter",
                url: "NotificariEmail/Filter/{_data}",
                defaults: new { controller = "NotificariEmail", action = "Index" }
            );
            routes.MapRoute(
                name: "NotificariEmailUpdateCheckDates",
                url: "NotificariEmail/UpdateCheckDates/{_timestamp}",
                defaults: new { controller = "NotificariEmail", action = "Index" }
            );
            routes.MapRoute(
                name: "SocietatiConfirmEmail",
                url: "SocietatiAsigurare/ConfirmEmailAddress/{societate}",
                defaults: new { controller = "SocietatiAsigurare", action = "Index" }
            );
            routes.MapRoute(
                name: "SocietatiCheckHost",
                url: "SocietatiAsigurare/CheckHostName/{emailAddress}",
                defaults: new { controller = "SocietatiAsigurare", action = "Index" }
            );

            routes.MapRoute(
                name: "ProceseStadiiList",
                url: "ProceseStadii/Details/{_id}/{_tip}",

                defaults: new
                {
                    controller = "ProceseStadii",
                    action = "Details"
                }
            );

        }
    }
}
