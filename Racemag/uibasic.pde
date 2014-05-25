class uibox extends uielem
{
  float Width, Height;
  color Color;
  
  uibox(float x, float y, float angle, float scale, float wdth, float hght, color clr)
  {
    super(x, y, angle, scale);
    Color = clr;
    Width = wdth;
    Height = hght;
    DrawDistance = wdth + hght;
  }
  
  void DrawThis(PGraphics v)
  {
    v.noStroke();
    v.fill(Color);
    v.rect(0, 0, Width, Height);
  }
}


class uirect extends uibox
{
  float EdgeWidth;
  color EdgeColor;
  
  uirect(float x, float y, float angle, float scale, float wdth, float hght, color clr, float edgeWdth, color edgeClr)
  {
    super(x, y, angle, scale, wdth, hght, clr);
    EdgeWidth = edgeWdth;
    EdgeColor = edgeClr;
  }
  
  void DrawThis(PGraphics v)
  {
    v.strokeWeight(EdgeWidth);
    v.stroke(EdgeColor);
    v.fill(Color);
    v.rect(0, 0, Width, Height);
  }
}


class uitext extends uibox
{
  String Text;
  PFont Font;
  float Size;
  boolean Boxed;
  int AlignX, AlignY;
  
  uitext(float x, float y, float angle, float scale, color clr, String txt, PFont fnt, float size)
  {
    super(x, y, angle, scale, 0, 0, clr);
    Text = txt; Font = fnt; Size = size; Boxed = false;
    AlignX = CENTER; AlignY = CENTER;
  }
  
  void DrawThis(PGraphics v)
  {
    v.textFont(Font, Size);
    v.textAlign(AlignX, AlignY);
    if(Boxed) v.text(Text, 0, 0, Width, Height);
    else v.text(Text, 0, 0);
  }
}


class uishape extends uibox
{
  PShape Shape;
  
  uishape(float x, float y, float angle, float scale, PShape shp)
  {
    super(x, y, angle, scale, shp.width, shp.height, 0);
    Shape = shp;
  }

  uishape(float x, float y, float angle, float scale, PImage txtr, int mode, int wrap, float[] vx, float[] vy, float[] ix, float[] iy)
  {
    super(x, y, angle, scale, 0, 0, 0);
    PShape s = createShape();
    s.beginShape();
    s.textureMode(mode);
    textureWrap(wrap);
    s.texture(txtr);
    for(int i=0; i<vx.length; i++)
    { s.vertex(vx[i], vy[i], ix[i], iy[i]); }
    s.endShape(CLOSE);
    Shape = s;
    Width = s.width;
    Height = s.height;
  }

  void DrawThis(PGraphics v)
  { v.shape(Shape, 0, 0, Width, Height); }
}


class uiimage extends uibox
{
  PImage Image;
  color TintColor;
  int BlendMode;
  boolean Tint, Blend;
  
  uiimage(float x, float y, float angle, float scale, PImage img)
  {
    super(x, y, angle, scale, img.width, img.height, 0);
    Image = img;
    TintColor = 0;
    BlendMode = BLEND;
    Tint = false;
    Blend = false;
  }
  
  void DrawThis(PGraphics v)
  {
    if(Tint) v.tint(TintColor);
    else v.noTint();
    if(Blend) v.blend(Image, 0, 0, Image.width, Image.height, 0, 0, (int) Width, (int) Height, BlendMode);
    else v.image(Image, 0, 0, Width, Height);
  }
}
