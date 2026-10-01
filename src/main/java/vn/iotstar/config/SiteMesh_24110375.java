package vn.iotstar.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import javax.servlet.annotation.WebFilter;
import javax.servlet.DispatcherType;

@WebFilter(filterName = "sitemesh", urlPatterns = "/*", dispatcherTypes = {DispatcherType.REQUEST, DispatcherType.FORWARD})
public class SiteMesh_24110375 extends ConfigurableSiteMeshFilter {
    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.addDecoratorPath("/admin/*", "/WEB-INF/decorators/admin.jsp")
               .addDecoratorPath("/*", "/WEB-INF/decorators/web.jsp")
               .addExcludedPath("/WEB-INF/decorators/*")
               .addExcludedPath("/assets/*");
    }
}

