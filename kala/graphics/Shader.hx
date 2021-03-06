package kala.graphics;

import kala.behaviors.Behavior;
import kala.objects.Object;
import kha.graphics4.FragmentShader;
import kha.graphics4.PipelineState;
import kha.graphics4.VertexData;
import kha.graphics4.VertexShader;
import kha.graphics4.VertexStructure;
import kha.Image;
import kha.Shaders;

/**
 * Used to set pipeline state for object rendering.
 * Can be added to object via object.addShader().
 * Multiple shaders can be chained together on a same object.
 * For single shader, it will be faster to set canvas pipeline directly via onPreDraw of object.
 */
@:allow(kala.objects.Object)
@:allow(kala.behaviors.Behavior)
class Shader {

	public var pipeline:PipelineState;
	
	public var size:UInt;
	
	public function destroy():Void {
		pipeline = null;
	}
	
	//
	
	function createPipeline(?structure:VertexStructure, ?vertexShader:VertexShader, ?fragmentShader:FragmentShader):Void {
		pipeline = new PipelineState();
		
		if (structure == null) {
			structure = new VertexStructure();
			structure.add("vertexPosition", VertexData.Float3);
			structure.add("texPosition", VertexData.Float2);
			structure.add("vertexColor", VertexData.Float4);
		}
		
		pipeline.inputLayout = [structure];
		
		pipeline.vertexShader = (vertexShader == null) ? Shaders.painter_image_vert : vertexShader;
		pipeline.fragmentShader = (fragmentShader == null) ? Shaders.painter_image_frag : fragmentShader;
		
		pipeline.compile();
	}
	
	function update(texture:Image, buffer:Image):Void {

	}

}