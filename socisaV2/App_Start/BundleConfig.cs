using System.Web;
using System.Web.Optimization;

namespace socisaWeb
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/Scripts/AllScripts").Include(
                        "~/Scripts/jquery-3.3.1.js",
                        "~/Scripts/jquery.validate.js",
                        "~/Scripts/jquery-ui-1.12.1.js",
                        "~/Scripts/modernizr-2.8.3.js",
                        "~/Scripts/bootstrap.js",
                        "~/Scripts/html5shiv.js",
                        "~/Scripts/respond.js",
                        "~/Scripts/angular.js",
                        "~/Scripts/angular-animate.js",
                        "~/bower_components/chart.js/dist/Chart.js",
                        "~/bower_components/angular-chart.js/dist/angular-chart.js",
                        "~/Scripts/ng-file-upload-shim.js",
                        "~/Scripts/ng-file-upload.js",
                        "~/Scripts/ngDialog.js",
                        "~/Scripts/jquery-idleTimeout.js",
                        "~/Scripts/spin.js",
                        "~/Scripts/SocisaApp.js",
                        "~/Scripts/Controllers/*Controller.js"
                        ));


            bundles.Add(new StyleBundle("~/Content/AllStyles").Include(
                      "~/Content/jquery-ui.css",
                      "~/Content/jquery-ui.theme.css",
                      "~/Content/ngDialog.css",
                      "~/Content/ngDialog-theme-default.css",
                      "~/Content/bootstrap.css",
                      "~/Content/font-awesome.css",
                      "~/Content/site.css"));

            #if DEBUG
                BundleTable.EnableOptimizations = false;
            #else
                BundleTable.EnableOptimizations = true;
            #endif
        }
    }
}
