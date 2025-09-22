// 新建 PassiveTextItem 用于被动文本的滚动
package game.view.item
{
    import game.uilts.GameFont;
    import starling.text.TextField;
    import starling.text.TextFormat;
    import zygame.display.BaseItem;

    public class PassiveTextItem extends BaseItem
    {
        private var _textField:TextField;

        public function PassiveTextItem()
        {
            super();
            
            // 创建 TextField
            var format:TextFormat = new TextFormat(GameFont.FONT_NAME, 12, 0xFFFFFF, "left");
            format.leading = 3;
            
            this._textField = new TextField(100, 0, "每次使用技能将恢复生命最大值1%", format); 
            this._textField.wordWrap = true;
            this.addChild(this._textField);
        }

        // 重写 set data 方法，参考RoleSelectItem
        override public function set data(value:Object) : void
        {
            super.data = value;

            if(value == null)
            {
                this._textField.text = "";
            }
            else
            {
                // 把被动文本直接设置给 TextField
                this._textField.text = value.toString();
            }
            
            // 让 TextField 的宽度等于父容器（List）的宽度
            // 然后让它的高度自动变化
            this._textField.width = this.width;
            this._textField.autoSize = "vertical";

            // 更新整个 Item 的高度，以便 List 能正确计算滚动
            this.height = this._textField.height;
        }
        
        // 重写 set width，确保宽度能正确传递给 TextField
        override public function set width(value:Number):void
        {
            super.width = value;
            if(this._textField)
            {
                this._textField.width = value;
                // 宽度变化后，高度可能也需要重新计算
                this.height = this._textField.height;
            }
        }
    }
}