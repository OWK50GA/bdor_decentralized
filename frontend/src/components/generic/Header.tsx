import Image from "next/image";
import bdor from '../../../public/bdor.png'

const Header = () => {
    return ( 
        <div className="flex justify-start items-center w-11/12 mx-auto my-7">
            <Image src={bdor} alt="Ballon D'Oro" height={100} width={100}/>
            <p className="text-4xl text-[#FFD700]">
                <span className="font-bold">Ballon d'Or</span> <span>2025</span>
            </p>
        </div>
    );
}
 
export default Header;