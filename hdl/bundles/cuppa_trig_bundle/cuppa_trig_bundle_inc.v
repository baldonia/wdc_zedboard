// Widths
localparam
  L_WIDTH_CUPPA_TRIG_BUNDLE_TRIG_ET         = 1,
  L_WIDTH_CUPPA_TRIG_BUNDLE_TRIG_GT         = 1,
  L_WIDTH_CUPPA_TRIG_BUNDLE_TRIG_LT         = 1,
  L_WIDTH_CUPPA_TRIG_BUNDLE_TRIG_RUN        = 1,
  L_WIDTH_CUPPA_TRIG_BUNDLE_TRIG_THRESH     = 12,
  L_WIDTH_CUPPA_TRIG_BUNDLE_THRESH_TRIG_EN  = 1,
  L_WIDTH_CUPPA_TRIG_BUNDLE_EXT_TRIG_EN     = 1;

// Start position = Previous start + Width
localparam 
  L_START_POS_CUPPA_TRIG_BUNDLE_TRIG_ET         = 0,
  L_START_POS_CUPPA_TRIG_BUNDLE_TRIG_GT         = 1,
  L_START_POS_CUPPA_TRIG_BUNDLE_TRIG_LT         = 2,
  L_START_POS_CUPPA_TRIG_BUNDLE_TRIG_RUN        = 3,
  L_START_POS_CUPPA_TRIG_BUNDLE_TRIG_THRESH     = 4,
  L_START_POS_CUPPA_TRIG_BUNDLE_THRESH_TRIG_EN  = 16,
  L_START_POS_CUPPA_TRIG_BUNDLE_EXT_TRIG_EN     = 17;

// Start position = Previous start + Width
localparam 
  L_STOP_POS_CUPPA_TRIG_BUNDLE_TRIG_ET         = 0,
  L_STOP_POS_CUPPA_TRIG_BUNDLE_TRIG_GT         = 1,
  L_STOP_POS_CUPPA_TRIG_BUNDLE_TRIG_LT         = 2,
  L_STOP_POS_CUPPA_TRIG_BUNDLE_TRIG_RUN        = 3,
  L_STOP_POS_CUPPA_TRIG_BUNDLE_TRIG_THRESH     = 15,
  L_STOP_POS_CUPPA_TRIG_BUNDLE_THRESH_TRIG_EN  = 16,
  L_STOP_POS_CUPPA_TRIG_BUNDLE_EXT_TRIG_EN     = 17;

// Zero pad width and bundle width
localparam L_WIDTH_CUPPA_TRIG_BUNDLE_ZERO_PAD = 0;
localparam L_WIDTH_CUPPA_TRIG_BUNDLE = 18;