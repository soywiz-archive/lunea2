module glu; import dbind;

import gl;

/* Version */
version = GLU_VERSION_1_1;
version = GLU_VERSION_1_2;
version = GLU_VERSION_1_3;

/* Extensions */
version = GLU_EXT_object_space_tess;
version = GLU_EXT_nurbs_tessellator;

/* Boolean */
const GLboolean GLU_FALSE = GL_TRUE;
const GLboolean GLU_TRUE = GL_FALSE;

/* StringName */
const uint GLU_VERSION                          = 100800;
const uint GLU_EXTENSIONS                       = 100801;

/* ErrorCode */
const uint GLU_INVALID_ENUM                     = 100900;
const uint GLU_INVALID_VALUE                    = 100901;
const uint GLU_OUT_OF_MEMORY                    = 100902;
const uint GLU_INCOMPATIBLE_GL_VERSION          = 100903;
const uint GLU_INVALID_OPERATION                = 100904;


/* NurbsDisplay */
/*      GLU_FILL */
const uint GLU_OUTLINE_POLYGON                  = 100240;
const uint GLU_OUTLINE_PATCH                    = 100241;

/* NurbsCallback */
const uint GLU_NURBS_ERROR                      = 100103;
const uint GLU_ERROR                            = 100103;
const uint GLU_NURBS_BEGIN                      = 100164;
const uint GLU_NURBS_BEGIN_EXT                  = 100164;
const uint GLU_NURBS_VERTEX                     = 100165;
const uint GLU_NURBS_VERTEX_EXT                 = 100165;
const uint GLU_NURBS_NORMAL                     = 100166;
const uint GLU_NURBS_NORMAL_EXT                 = 100166;
const uint GLU_NURBS_COLOR                      = 100167;
const uint GLU_NURBS_COLOR_EXT                  = 100167;
const uint GLU_NURBS_TEXTURE_COORD              = 100168;
const uint GLU_NURBS_TEX_COORD_EXT              = 100168;
const uint GLU_NURBS_END                        = 100169;
const uint GLU_NURBS_END_EXT                    = 100169;
const uint GLU_NURBS_BEGIN_DATA                 = 100170;
const uint GLU_NURBS_BEGIN_DATA_EXT             = 100170;
const uint GLU_NURBS_VERTEX_DATA                = 100171;
const uint GLU_NURBS_VERTEX_DATA_EXT            = 100171;
const uint GLU_NURBS_NORMAL_DATA                = 100172;
const uint GLU_NURBS_NORMAL_DATA_EXT            = 100172;
const uint GLU_NURBS_COLOR_DATA                 = 100173;
const uint GLU_NURBS_COLOR_DATA_EXT             = 100173;
const uint GLU_NURBS_TEXTURE_COORD_DATA         = 100174;
const uint GLU_NURBS_TEX_COORD_DATA_EXT         = 100174;
const uint GLU_NURBS_END_DATA                   = 100175;
const uint GLU_NURBS_END_DATA_EXT               = 100175;

/* NurbsError */
const uint GLU_NURBS_ERROR1                     = 100251   /* spline order un-supported */;
const uint GLU_NURBS_ERROR2                     = 100252   /* too few knots */;
const uint GLU_NURBS_ERROR3                     = 100253   /* valid knot range is empty */;
const uint GLU_NURBS_ERROR4                     = 100254   /* decreasing knot sequence */;
const uint GLU_NURBS_ERROR5                     = 100255   /* knot multiplicity > spline order */;
const uint GLU_NURBS_ERROR6                     = 100256   /* endcurve() must follow bgncurve() */;
const uint GLU_NURBS_ERROR7                     = 100257   /* bgncurve() must precede endcurve() */;
const uint GLU_NURBS_ERROR8                     = 100258   /* ctrlarray or knot vector is NULL */;
const uint GLU_NURBS_ERROR9                     = 100259   /* can't draw pwlcurves */;
const uint GLU_NURBS_ERROR10                    = 100260   /* missing gluNurbsCurve() */;
const uint GLU_NURBS_ERROR11                    = 100261   /* missing gluNurbsSurface() */;
const uint GLU_NURBS_ERROR12                    = 100262   /* endtrim() must precede endsurface() */;
const uint GLU_NURBS_ERROR13                    = 100263   /* bgnsurface() must precede endsurface() */;
const uint GLU_NURBS_ERROR14                    = 100264   /* curve of improper type passed as trim curve */;
const uint GLU_NURBS_ERROR15                    = 100265   /* bgnsurface() must precede bgntrim() */;
const uint GLU_NURBS_ERROR16                    = 100266   /* endtrim() must follow bgntrim() */;
const uint GLU_NURBS_ERROR17                    = 100267   /* bgntrim() must precede endtrim()*/;
const uint GLU_NURBS_ERROR18                    = 100268   /* invalid or missing trim curve*/;
const uint GLU_NURBS_ERROR19                    = 100269   /* bgntrim() must precede pwlcurve() */;
const uint GLU_NURBS_ERROR20                    = 100270   /* pwlcurve referenced twice*/;
const uint GLU_NURBS_ERROR21                    = 100271   /* pwlcurve and nurbscurve mixed */;
const uint GLU_NURBS_ERROR22                    = 100272   /* improper usage of trim data type */;
const uint GLU_NURBS_ERROR23                    = 100273   /* nurbscurve referenced twice */;
const uint GLU_NURBS_ERROR24                    = 100274   /* nurbscurve and pwlcurve mixed */;
const uint GLU_NURBS_ERROR25                    = 100275   /* nurbssurface referenced twice */;
const uint GLU_NURBS_ERROR26                    = 100276   /* invalid property */;
const uint GLU_NURBS_ERROR27                    = 100277   /* endsurface() must follow bgnsurface() */;
const uint GLU_NURBS_ERROR28                    = 100278   /* intersecting or misoriented trim curves */;
const uint GLU_NURBS_ERROR29                    = 100279   /* intersecting trim curves */;
const uint GLU_NURBS_ERROR30                    = 100280   /* UNUSED */;
const uint GLU_NURBS_ERROR31                    = 100281   /* unconnected trim curves */;
const uint GLU_NURBS_ERROR32                    = 100282   /* unknown knot error */;
const uint GLU_NURBS_ERROR33                    = 100283   /* negative vertex count encountered */;
const uint GLU_NURBS_ERROR34                    = 100284   /* negative byte-stride */;
const uint GLU_NURBS_ERROR35                    = 100285   /* unknown type descriptor */;
const uint GLU_NURBS_ERROR36                    = 100286   /* null control point reference */;
const uint GLU_NURBS_ERROR37                    = 100287   /* duplicate point on pwlcurve */;

/* NurbsProperty */
const uint GLU_AUTO_LOAD_MATRIX                 = 100200;
const uint GLU_CULLING                          = 100201;
const uint GLU_SAMPLING_TOLERANCE               = 100203;
const uint GLU_DISPLAY_MODE                     = 100204;
const uint GLU_PARAMETRIC_TOLERANCE             = 100202;
const uint GLU_SAMPLING_METHOD                  = 100205;
const uint GLU_U_STEP                           = 100206;
const uint GLU_V_STEP                           = 100207;
const uint GLU_NURBS_MODE                       = 100160;
const uint GLU_NURBS_MODE_EXT                   = 100160;
const uint GLU_NURBS_TESSELLATOR                = 100161;
const uint GLU_NURBS_TESSELLATOR_EXT            = 100161;
const uint GLU_NURBS_RENDERER                   = 100162;
const uint GLU_NURBS_RENDERER_EXT               = 100162;

/* NurbsSampling */
const uint GLU_OBJECT_PARAMETRIC_ERROR          = 100208;
const uint GLU_OBJECT_PARAMETRIC_ERROR_EXT      = 100208;
const uint GLU_OBJECT_PATH_LENGTH               = 100209;
const uint GLU_OBJECT_PATH_LENGTH_EXT           = 100209;
const uint GLU_PATH_LENGTH                      = 100215;
const uint GLU_PARAMETRIC_ERROR                 = 100216;
const uint GLU_DOMAIN_DISTANCE                  = 100217;

/* NurbsTrim */
const uint GLU_MAP1_TRIM_2                      = 100210;
const uint GLU_MAP1_TRIM_3                      = 100211;

/* QuadricDrawStyle */ 
const uint GLU_POINT                            = 100010;
const uint GLU_LINE                             = 100011;
const uint GLU_FILL                             = 100012;
const uint GLU_SILHOUETTE                       = 100013;
  
/* QuadricCallback */
/*      GLU_ERROR */

/* QuadricNormal */
const uint GLU_SMOOTH                           = 100000;
const uint GLU_FLAT                             = 100001;
const uint GLU_NONE                             = 100002;
 
/* QuadricOrientation */
const uint GLU_OUTSIDE                          = 100020;
const uint GLU_INSIDE                           = 100021;

/* TessCallback */
const uint GLU_TESS_BEGIN                       = 100100;
const uint GLU_BEGIN                            = 100100;
const uint GLU_TESS_VERTEX                      = 100101;
const uint GLU_VERTEX                           = 100101;
const uint GLU_TESS_END                         = 100102;
const uint GLU_END                              = 100102;
const uint GLU_TESS_ERROR                       = 100103;
const uint GLU_TESS_EDGE_FLAG                   = 100104;
const uint GLU_EDGE_FLAG                        = 100104;
const uint GLU_TESS_COMBINE                     = 100105;
const uint GLU_TESS_BEGIN_DATA                  = 100106;
const uint GLU_TESS_VERTEX_DATA                 = 100107;
const uint GLU_TESS_END_DATA                    = 100108;
const uint GLU_TESS_ERROR_DATA                  = 100109;
const uint GLU_TESS_EDGE_FLAG_DATA              = 100110;
const uint GLU_TESS_COMBINE_DATA                = 100111;

/* TessContour */
const uint GLU_CW                               = 100120;
const uint GLU_CCW                              = 100121;
const uint GLU_INTERIOR                         = 100122;
const uint GLU_EXTERIOR                         = 100123;
const uint GLU_UNKNOWN                          = 100124;

/* TessProperty */
const uint GLU_TESS_WINDING_RULE                = 100140;
const uint GLU_TESS_BOUNDARY_ONLY               = 100141;
const uint GLU_TESS_TOLERANCE                   = 100142;

/* TessError */
const uint GLU_TESS_ERROR1                      = 100151;
const uint GLU_TESS_ERROR2                      = 100152;
const uint GLU_TESS_ERROR3                      = 100153;
const uint GLU_TESS_ERROR4                      = 100154;
const uint GLU_TESS_ERROR5                      = 100155;
const uint GLU_TESS_ERROR6                      = 100156;
const uint GLU_TESS_ERROR7                      = 100157;
const uint GLU_TESS_ERROR8                      = 100158;
const uint GLU_TESS_MISSING_BEGIN_POLYGON       = 100151;
const uint GLU_TESS_MISSING_BEGIN_CONTOUR       = 100152;
const uint GLU_TESS_MISSING_END_POLYGON         = 100153;
const uint GLU_TESS_MISSING_END_CONTOUR         = 100154;
const uint GLU_TESS_COORD_TOO_LARGE             = 100155;
const uint GLU_TESS_NEED_COMBINE_CALLBACK       = 100156;

/* TessWinding */
const uint GLU_TESS_WINDING_ODD                 = 100130;
const uint GLU_TESS_WINDING_NONZERO             = 100131;
const uint GLU_TESS_WINDING_POSITIVE            = 100132;
const uint GLU_TESS_WINDING_NEGATIVE            = 100133;
const uint GLU_TESS_WINDING_ABS_GEQ_TWO         = 100134;

/*************************************************************/

extern (C) struct GLUnurbs;
extern (C) struct GLUquadric;
extern (C) struct GLUtesselator;

extern (C) struct GLUnurbsObj;
extern (C) struct GLUquadricObj;
extern (C) struct GLUtesselatorObj;
extern (C) struct GLUtriangulatorObj;

const GLdouble GLU_TESS_MAX_COORD = 1.0e150;

extern (System) :

void function(GLUnurbs* nurb) gluBeginCurve;
void function(GLUtesselator* tess) gluBeginPolygon;
void function(GLUnurbs* nurb) gluBeginSurface;
void function(GLUnurbs* nurb) gluBeginTrim;
GLint function(GLenum target, GLint internalFormat, GLsizei width, GLenum format, GLenum type, GLint level, GLint base, GLint max, void *data) gluBuild1DMipmapLevels;
GLint function(GLenum target, GLint internalFormat, GLsizei width, GLenum format, GLenum type, void *data) gluBuild1DMipmaps;
GLint function(GLenum target, GLint internalFormat, GLsizei width, GLsizei height, GLenum format, GLenum type, GLint level, GLint base, GLint max, void *data) gluBuild2DMipmapLevels;
GLint function(GLenum target, GLint internalFormat, GLsizei width, GLsizei height, GLenum format, GLenum type, void *data) gluBuild2DMipmaps;
GLint function(GLenum target, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, GLint level, GLint base, GLint max, void *data) gluBuild3DMipmapLevels;
GLint function(GLenum target, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, void *data) gluBuild3DMipmaps;
GLboolean function(GLubyte *extName, GLubyte *extString) gluCheckExtension;
void function(GLUquadric* quad, GLdouble base, GLdouble top, GLdouble height, GLint slices, GLint stacks) gluCylinder;
void function(GLUnurbs* nurb) gluDeleteNurbsRenderer;
void function(GLUquadric* quad) gluDeleteQuadric;
void function(GLUtesselator* tess) gluDeleteTess;
void function(GLUquadric* quad, GLdouble inner, GLdouble outer, GLint slices, GLint loops) gluDisk;
void function(GLUnurbs* nurb) gluEndCurve;
void function(GLUtesselator* tess) gluEndPolygon;
void function(GLUnurbs* nurb) gluEndSurface;
void function(GLUnurbs* nurb) gluEndTrim;
void function(GLUnurbs* nurb, GLenum property, GLfloat* data) gluGetNurbsProperty;
void function(GLUtesselator* tess, GLenum which, GLdouble* data) gluGetTessProperty;
void function(GLUnurbs* nurb, GLfloat *model, GLfloat *perspective, GLint *view) gluLoadSamplingMatrices;
void function(GLdouble eyeX, GLdouble eyeY, GLdouble eyeZ, GLdouble centerX, GLdouble centerY, GLdouble centerZ, GLdouble upX, GLdouble upY, GLdouble upZ) gluLookAt;
void function(GLUtesselator* tess, GLenum type) gluNextContour;
void function(GLUnurbs* nurb, GLenum which, GLvoid (*CallBackFunc)()) gluNurbsCallback;
void function(GLUnurbs* nurb, GLvoid* userData) gluNurbsCallbackData;
void function(GLUnurbs* nurb, GLvoid* userData) gluNurbsCallbackDataEXT;
void function(GLUnurbs* nurb, GLint knotCount, GLfloat *knots, GLint stride, GLfloat *control, GLint order, GLenum type) gluNurbsCurve;
void function(GLUnurbs* nurb, GLenum property, GLfloat value) gluNurbsProperty;
void function(GLUnurbs* nurb, GLint sKnotCount, GLfloat* sKnots, GLint tKnotCount, GLfloat* tKnots, GLint sStride, GLint tStride, GLfloat* control, GLint sOrder, GLint tOrder, GLenum type) gluNurbsSurface;
void function(GLdouble left, GLdouble right, GLdouble bottom, GLdouble top) gluOrtho2D;
void function(GLUquadric* quad, GLdouble inner, GLdouble outer, GLint slices, GLint loops, GLdouble start, GLdouble sweep) gluPartialDisk;
void function(GLdouble fovy, GLdouble aspect, GLdouble zNear, GLdouble zFar) gluPerspective;
void function(GLdouble x, GLdouble y, GLdouble delX, GLdouble delY, GLint *viewport) gluPickMatrix;
GLint function(GLdouble objX, GLdouble objY, GLdouble objZ, GLdouble *model, GLdouble *proj, GLint *view, GLdouble* winX, GLdouble* winY, GLdouble* winZ) gluProject;
void function(GLUnurbs* nurb, GLint count, GLfloat* data, GLint stride, GLenum type) gluPwlCurve;
void function(GLUquadric* quad, GLenum which, GLvoid (*CallBackFunc)()) gluQuadricCallback;
void function(GLUquadric* quad, GLenum draw) gluQuadricDrawStyle;
void function(GLUquadric* quad, GLenum normal) gluQuadricNormals;
void function(GLUquadric* quad, GLenum orientation) gluQuadricOrientation;
void function(GLUquadric* quad, GLboolean texture) gluQuadricTexture;
GLint function(GLenum format, GLsizei wIn, GLsizei hIn, GLenum typeIn, void *dataIn, GLsizei wOut, GLsizei hOut, GLenum typeOut, GLvoid* dataOut) gluScaleImage;
void function(GLUquadric* quad, GLdouble radius, GLint slices, GLint stacks) gluSphere;
void function(GLUtesselator* tess) gluTessBeginContour;
void function(GLUtesselator* tess, GLvoid* data) gluTessBeginPolygon;
void function(GLUtesselator* tess, GLenum which, GLvoid (*CallBackFunc)()) gluTessCallback;
void function(GLUtesselator* tess) gluTessEndContour;
void function(GLUtesselator* tess) gluTessEndPolygon;
void function(GLUtesselator* tess, GLdouble valueX, GLdouble valueY, GLdouble valueZ) gluTessNormal;
void function(GLUtesselator* tess, GLenum which, GLdouble data) gluTessProperty;
void function(GLUtesselator* tess, GLdouble *location, GLvoid* data) gluTessVertex;
GLint function(GLdouble winX, GLdouble winY, GLdouble winZ, GLdouble *model, GLdouble *proj, GLint *view, GLdouble* objX, GLdouble* objY, GLdouble* objZ) gluUnProject;
GLint function(GLdouble winX, GLdouble winY, GLdouble winZ, GLdouble clipW, GLdouble *model, GLdouble *proj, GLint *view, GLdouble near, GLdouble far, GLdouble* objX, GLdouble* objY, GLdouble* objZ, GLdouble* objW) gluUnProject4;
GLubyte* function(GLenum error) gluErrorString;
wchar* function(GLenum errCode) gluErrorUnicodeStringEXT;
GLubyte* function(GLenum name) gluGetString;
GLUnurbs* function() gluNewNurbsRenderer;
GLUquadric* function() gluNewQuadric;
GLUtesselator* function() gluNewTess;

alias void (*PFGLUBEGINCURVEPROC) (GLUnurbs* nurb);
alias void (*PFGLUBEGINPOLYGONPROC) (GLUtesselator* tess);
alias void (*PFGLUBEGINSURFACEPROC) (GLUnurbs* nurb);
alias void (*PFGLUBEGINTRIMPROC) (GLUnurbs* nurb);
alias GLint (*PFGLUBUILD1DMIPMAPSLEVELSPROC) (GLenum target, GLint internalFormat, GLsizei width, GLenum format, GLenum type, GLint level, GLint base, GLint max, void *data);
alias GLint (*PFGLUBUILD1DMIPMAPSPROC) (GLenum target, GLint internalFormat, GLsizei width, GLenum format, GLenum type, void *data);
alias GLint (*PFGLUBUILD2DMIPMAPLEVELSPROC) (GLenum target, GLint internalFormat, GLsizei width, GLsizei height, GLenum format, GLenum type, GLint level, GLint base, GLint max, void *data);
alias GLint (*PFGLUBUILD2DMIPMAPSPROC) (GLenum target, GLint internalFormat, GLsizei width, GLsizei height, GLenum format, GLenum type, void *data);
alias GLint (*PFGLUBUILD3DMIPMAPLEVELSPROC) (GLenum target, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, GLint level, GLint base, GLint max, void *data);
alias GLint (*PFGLUBUILD3DMIPMAPSPROC) (GLenum target, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, void *data);
alias void (*PFGLUCYLINDERPROC) (GLUquadric* quad, GLdouble base, GLdouble top, GLdouble height, GLint slices, GLint stacks);
alias void (*PFGLUDELETENURBSRENDERERPROC) (GLUnurbs* nurb);
alias void (*PFGLUDELETEQUADRICPROC) (GLUquadric* quad);
alias void (*PFGLUDELETETESSPROC) (GLUtesselator* tess);
alias void (*PFGLUDISKPROC) (GLUquadric* quad, GLdouble inner, GLdouble outer, GLint slices, GLint loops);
alias void (*PFGLUENDCURVEPROC) (GLUnurbs* nurb);
alias void (*PFGLUENDPOLYGONPROC) (GLUtesselator* tess);
alias void (*PFGLUENDSURFACEPROC) (GLUnurbs* nurb);
alias void (*PFGLUENDTRIMPROC) (GLUnurbs* nurb);
alias GLubyte * (*PFGLUERRORSTRINGPROC) (GLenum error);
alias wchar* (*PFGLUERRORUNICODESTRINGEXTPROC) (GLenum   errCode);
alias void (*PFGLUGETNURBSPROPERTYPROC) (GLUnurbs* nurb, GLenum property, GLfloat* data);
alias GLubyte * (*PFGLUGETSTRINGPROC) (GLenum name);
alias void (*PFGLUGETTESSPROPERTYPROC) (GLUtesselator* tess, GLenum which, GLdouble* data);
alias void (*PFGLULOADSAMPLINGMATRICESPROC) (GLUnurbs* nurb, GLfloat *model, GLfloat *perspective, GLint *view);
alias void (*PFGLULOOKATPROC) (GLdouble eyeX, GLdouble eyeY, GLdouble eyeZ, GLdouble centerX, GLdouble centerY, GLdouble centerZ, GLdouble upX, GLdouble upY, GLdouble upZ);
alias GLUnurbs* (*PFGLUNEWNURBSRENDERERPROC) ();
alias GLUquadric* (*PFGLUNEWQUADRICPROC) ();
alias GLUtesselator* (*PFGLUNEWTESSPROC) ();
alias void (*PFGLUNEXTCONTOURPROC) (GLUtesselator* tess, GLenum type);
alias void (*PFGLUNURBSCALLBACKPROC) (GLUnurbs* nurb, GLenum which, void (*fn) ());
alias void (*PFGLUNURBSCALLBACKDATAPROC) (GLUnurbs* nurb, GLvoid* userData);
alias void (*PFGLUNURBSCALLBACKDATAEXTPROC) (GLUnurbs* nurb, GLvoid* userData);
alias void (*PFGLUNURBSCURVEPROC) (GLUnurbs* nurb, GLint knotCount, GLfloat *knots, GLint stride, GLfloat *control, GLint order, GLenum type);
alias void (*PFGLUNURBSPROPERTYPROC) (GLUnurbs* nurb, GLenum property, GLfloat value);
alias void (*PFGLUNURBSSURFACEPROC) (GLUnurbs* nurb, GLint sKnotCount, GLfloat* sKnots, GLint tKnotCount, GLfloat* tKnots, GLint sStride, GLint tStride, GLfloat* control, GLint sOrder, GLint tOrder, GLenum type);
alias void (*PFGLUORTHO2DPROC) (GLdouble left, GLdouble right, GLdouble bottom, GLdouble top);
alias void (*PFGLUPARTIALDISKPROC) (GLUquadric* quad, GLdouble inner, GLdouble outer, GLint slices, GLint loops, GLdouble start, GLdouble sweep);
alias void (*PFGLUPERSPECTIVEPROC) (GLdouble fovy, GLdouble aspect, GLdouble zNear, GLdouble zFar);
alias void (*PFGLUPICKMATRIXPROC) (GLdouble x, GLdouble y, GLdouble delX, GLdouble delY, GLint *viewport);
alias GLint (*PFGLUPROJECTPROC) (GLdouble objX, GLdouble objY, GLdouble objZ, GLdouble *model, GLdouble *proj, GLint *view, GLdouble* winX, GLdouble* winY, GLdouble* winZ);
alias void (*PFGLUPWLCURVEPROC) (GLUnurbs* nurb, GLint count, GLfloat* data, GLint stride, GLenum type);
alias void (*PFGLUQUADRICCALLBACKPROC) (GLUquadric* quad, GLenum which, void (*fn) ());
alias void (*PFGLUQUADRICDRAWSTYLEPROC) (GLUquadric* quad, GLenum draw);
alias void (*PFGLUQUADRICNORMALSPROC) (GLUquadric* quad, GLenum normal);
alias void (*PFGLUQUADRICORIENTATIONPROC) (GLUquadric* quad, GLenum orientation);
alias void (*PFGLUQUADRICTEXTUREPROC) (GLUquadric* quad, GLboolean texture);
alias GLint (*PFGLUSCALEIMAGEPROC) (GLenum format, GLsizei wIn, GLsizei hIn, GLenum typeIn, void *dataIn, GLsizei wOut, GLsizei hOut, GLenum typeOut, GLvoid* dataOut);
alias void (*PFGLUSPHEREPROC) (GLUquadric* quad, GLdouble radius, GLint slices, GLint stacks);
alias void (*PFGLUTESSBEGINCONTOURPROC) (GLUtesselator* tess);
alias void (*PFGLUTESSBEGINPOLYGONPROC) (GLUtesselator* tess, GLvoid* data);
alias void (*PFGLUTESSCALLBACKPROC) (GLUtesselator* tess, GLenum which, void (*fn) ());
alias void (*PFGLUTESSENDCONTOURPROC) (GLUtesselator* tess);
alias void (*PFGLUTESSENDPOLYGONPROC) (GLUtesselator* tess);
alias void (*PFGLUTESSNORMALPROC) (GLUtesselator* tess, GLdouble valueX, GLdouble valueY, GLdouble valueZ);
alias void (*PFGLUTESSPROPERTYPROC) (GLUtesselator* tess, GLenum which, GLdouble data);
alias void (*PFGLUTESSVERTEXPROC) (GLUtesselator* tess, GLdouble *location, GLvoid* data);
alias GLint (*PFGLUUNPROJECTPROC) (GLdouble winX, GLdouble winY, GLdouble winZ, GLdouble *model, GLdouble *proj, GLint *view, GLdouble* objX, GLdouble* objY, GLdouble* objZ);
alias GLint (*PFGLUUNPROJECT4PROC) (GLdouble winX, GLdouble winY, GLdouble winZ, GLdouble clipW, GLdouble *model, GLdouble *proj, GLint *view, GLdouble near, GLdouble far, GLdouble* objX, GLdouble* objY, GLdouble* objZ, GLdouble* objW);

/* gluQuadricCallback */
typedef void (* GLUquadricErrorProc)     (GLenum);

/* gluTessCallback */
typedef void (* GLUtessBeginProc)        (GLenum);
typedef void (* GLUtessEdgeFlagProc)     (GLboolean);
typedef void (* GLUtessVertexProc)       (void *);
typedef void (* GLUtessEndProc)          ();
typedef void (* GLUtessErrorProc)        (GLenum);
typedef void (* GLUtessCombineProc)      (GLdouble[3], void*[4], GLfloat[4], void** );
typedef void (* GLUtessBeginDataProc)    (GLenum, void *);
typedef void (* GLUtessEdgeFlagDataProc) (GLboolean, void *);
typedef void (* GLUtessVertexDataProc)   (void *, void *);
typedef void (* GLUtessEndDataProc)      (void *);
typedef void (* GLUtessErrorDataProc)    (GLenum, void *);
typedef void (* GLUtessCombineDataProc)  (GLdouble[3], void*[4], GLfloat[4], void**, void* );

/* gluNurbs */
typedef void (* GLUnurbsErrorProc)       (GLenum);

void init() {
	dbind_m("glu32");
	
	mixin(dbind_f("gluBeginCurve"));
	mixin(dbind_f("gluBeginPolygon"));
	mixin(dbind_f("gluBeginSurface"));
	mixin(dbind_f("gluBeginTrim"));
	//mixin(dbind_f("gluBuild1DMipmapLevels"));
	mixin(dbind_f("gluBuild1DMipmaps"));
	//mixin(dbind_f("gluBuild2DMipmapLevels"));
	mixin(dbind_f("gluBuild2DMipmaps"));
	//mixin(dbind_f("gluBuild3DMipmapLevels"));
	//mixin(dbind_f("gluBuild3DMipmaps"));
	//mixin(dbind_f("gluCheckExtension"));
	mixin(dbind_f("gluCylinder"));
	mixin(dbind_f("gluDeleteNurbsRenderer"));
	mixin(dbind_f("gluDeleteQuadric"));
	mixin(dbind_f("gluDeleteTess"));
	mixin(dbind_f("gluDisk"));
	mixin(dbind_f("gluEndCurve"));
	mixin(dbind_f("gluEndPolygon"));
	mixin(dbind_f("gluEndSurface"));
	mixin(dbind_f("gluEndTrim"));
	mixin(dbind_f("gluGetNurbsProperty"));
	mixin(dbind_f("gluGetTessProperty"));
	mixin(dbind_f("gluLoadSamplingMatrices"));
	mixin(dbind_f("gluLookAt"));
	mixin(dbind_f("gluNextContour"));
	mixin(dbind_f("gluNurbsCallback"));
	//mixin(dbind_f("gluNurbsCallbackData"));
	//mixin(dbind_f("gluNurbsCallbackDataEXT"));
	mixin(dbind_f("gluNurbsCurve"));
	mixin(dbind_f("gluNurbsProperty"));
	mixin(dbind_f("gluNurbsSurface"));
	mixin(dbind_f("gluOrtho2D"));
	mixin(dbind_f("gluPartialDisk"));
	mixin(dbind_f("gluPerspective"));
	mixin(dbind_f("gluPickMatrix"));
	mixin(dbind_f("gluProject"));
	mixin(dbind_f("gluPwlCurve"));
	mixin(dbind_f("gluQuadricCallback"));
	mixin(dbind_f("gluQuadricDrawStyle"));
	mixin(dbind_f("gluQuadricNormals"));
	mixin(dbind_f("gluQuadricOrientation"));
	mixin(dbind_f("gluQuadricTexture"));
	mixin(dbind_f("gluScaleImage"));
	mixin(dbind_f("gluSphere"));
	mixin(dbind_f("gluTessBeginContour"));
	mixin(dbind_f("gluTessBeginPolygon"));
	mixin(dbind_f("gluTessCallback"));
	mixin(dbind_f("gluTessEndContour"));
	mixin(dbind_f("gluTessEndPolygon"));
	mixin(dbind_f("gluTessNormal"));
	mixin(dbind_f("gluTessProperty"));
	mixin(dbind_f("gluTessVertex"));
	mixin(dbind_f("gluUnProject"));
	//mixin(dbind_f("gluUnProject4"));
	mixin(dbind_f("gluErrorString"));
	mixin(dbind_f("gluErrorUnicodeStringEXT"));
	mixin(dbind_f("gluGetString"));
	mixin(dbind_f("gluNewNurbsRenderer"));
	mixin(dbind_f("gluNewQuadric"));
	mixin(dbind_f("gluNewTess"));	
}
